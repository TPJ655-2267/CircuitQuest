#pragma once
#include <Arduino.h>
#include <WebServer.h>
#include <esp_system.h>
#include <esp_timer.h>
#include <mbedtls/sha256.h>
#include "dashboard_credentials.h"

const char LOGIN_HTML[] PROGMEM = R"CQLOGIN(<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>CircuitQuest | Sign in</title>
<style>:root{color-scheme:dark;font-family:system-ui,sans-serif;background:#0b1017;color:#e8eef5}*{box-sizing:border-box}body{margin:0;min-height:100vh;display:grid;place-items:center;padding:24px;background:radial-gradient(ellipse at top,#1a3026,#0b1017 65%)}main{width:100%;max-width:420px;padding:32px;border:1px solid #304336;border-radius:20px;background:#121b26}.brand{font-weight:750;font-size:24px;letter-spacing:-1px}.brand span{color:#b7ed9c}.eyebrow{font-size:11px;letter-spacing:2px;color:#9eabbc;margin-top:8px;text-transform:uppercase}h1{font-size:30px;letter-spacing:-1px;margin:28px 0 8px}p{font-size:14px;color:#9eabbc;line-height:1.6}label{display:block;font-size:13px;margin:22px 0 8px}input{width:100%;background:#0b1017;border:1px solid #38475a;border-radius:9px;padding:13px;color:#fff;font:inherit}button{width:100%;margin-top:26px;border:0;border-radius:9px;background:#b7ed9c;color:#102018;padding:14px;font:inherit;font-weight:700;cursor:pointer}input:focus-visible,button:focus-visible{outline:2px solid #b7ed9c;outline-offset:3px}.error{color:#ffcda2;background:#38251c;padding:12px;border-radius:8px}.note{font-size:12px;margin-top:22px}[hidden]{display:none}</style></head>
<body><main><div class="brand">Circuit<span>Quest</span></div><div class="eyebrow">Personnel access</div><h1>Welcome back.</h1><p>Sign in to view game results and control the connected outputs.</p><p id="error" class="error" role="alert" hidden></p>
<form method="post" action="/login"><label for="username">Username</label><input id="username" name="username" autocomplete="username" maxlength="64" required autocapitalize="none" spellcheck="false"><label for="password">Password</label><input id="password" name="password" type="password" autocomplete="current-password" maxlength="128" required><button type="submit">Sign in</button></form><p class="note">Personnel sign-in is separate from the player ID entered on the game keypad.</p></main>
<script>const error=new URLSearchParams(location.search).get('error');if(error){const message=document.getElementById('error');message.hidden=false;message.textContent=error==='wait'?'Too many attempts. Wait 30 seconds and try again.':'Incorrect username or password. Try again.'}</script></body></html>)CQLOGIN";

class DashboardAuth {
public:
    explicit DashboardAuth(WebServer& server) : server(server) {}

    bool authorized() {
        const String token = cookieToken();
        if (token.length() != 32) return false;
        const uint64_t now = esp_timer_get_time();
        for (auto& session : sessions) {
            if (session.expiresUs > now && token == session.token) return true;
        }
        return false;
    }

    bool require(bool api = true) {
        if (authorized()) return true;
        server.sendHeader("Cache-Control", "no-store");
        if (api) server.send(401, "application/json", "{\"error\":\"Sign in required\"}");
        else redirect("/login");
        return false;
    }

    void loginPage() {
        if (authorized()) { redirect("/"); return; }
        server.sendHeader("Cache-Control", "no-store");
        server.sendHeader("X-Frame-Options", "DENY");
        server.send_P(200, "text/html; charset=utf-8", LOGIN_HTML);
    }

    void login() {
        const uint64_t now = esp_timer_get_time();
        if (now - attemptWindowUs >= 30000000ULL) { failedAttempts = 0; attemptWindowUs = now; }
        if (failedAttempts >= 5) { redirect("/login?error=wait"); return; }
        const String username = server.arg("username"), password = server.arg("password");
        if (username.length() > 64 || password.length() > 128) { reject(); return; }
        uint8_t hash[32];
        if (mbedtls_sha256_ret(reinterpret_cast<const unsigned char*>(password.c_str()), password.length(), hash, 0) != 0) {
            reject(); return;
        }
        char hex[65];
        for (uint8_t i = 0; i < 32; ++i) snprintf(hex + i * 2, 3, "%02x", hash[i]);
        uint8_t difference = 0;
        for (uint8_t i = 0; i < 64; ++i) difference |= hex[i] ^ DASHBOARD_PASSWORD_SHA256[i];
        if (username != DASHBOARD_ADMIN_USER || difference != 0) { reject(); return; }
        failedAttempts = 0;
        uint8_t slot = 0;
        for (uint8_t i = 0; i < 4; ++i) {
            if (sessions[i].expiresUs <= now) { slot = i; break; }
            if (sessions[i].expiresUs < sessions[slot].expiresUs) slot = i;
        }
        // Invalidate this browser's old session before assigning a fresh token.
        const String oldToken = cookieToken();
        for (auto& session : sessions) if (oldToken == session.token) session.expiresUs = 0;
        uint8_t random[16];
        esp_fill_random(random, sizeof(random));
        for (uint8_t i = 0; i < 16; ++i) snprintf(sessions[slot].token + i * 2, 3, "%02x", random[i]);
        sessions[slot].expiresUs = now + 8ULL * 60 * 60 * 1000000;
        server.sendHeader("Set-Cookie", String("cq_session=") + sessions[slot].token + "; Path=/; HttpOnly; SameSite=Strict; Max-Age=28800");
        redirect("/");
    }

    void logout() {
        const String token = cookieToken();
        for (auto& session : sessions) if (token == session.token) session.expiresUs = 0;
        server.sendHeader("Set-Cookie", "cq_session=; Path=/; HttpOnly; SameSite=Strict; Max-Age=0");
        redirect("/login");
    }

private:
    struct Session { char token[33] = {}; uint64_t expiresUs = 0; } sessions[4];
    WebServer& server;
    uint8_t failedAttempts = 0;
    uint64_t attemptWindowUs = 0;

    void redirect(const char* path) {
        server.sendHeader("Cache-Control", "no-store");
        server.sendHeader("Location", path);
        server.send(303, "text/plain", "");
    }
    void reject() { ++failedAttempts; redirect("/login?error=invalid"); }
    String cookieToken() {
        const String cookie = server.header("Cookie");
        int start = 0;
        while (start < static_cast<int>(cookie.length())) {
            int end = cookie.indexOf(';', start);
            if (end < 0) end = cookie.length();
            String part = cookie.substring(start, end);
            part.trim();
            if (part.startsWith("cq_session=")) return part.substring(11);
            start = end + 1;
        }
        return "";
    }
};
