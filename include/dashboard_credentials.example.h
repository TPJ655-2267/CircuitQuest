#pragma once
// Copy to dashboard_credentials.h (ignored by Git) before building.
// Replace the digest with the 64-character lowercase SHA-256 of your password.
// PowerShell can generate it without storing the plaintext in this file:
// $sha = [System.Security.Cryptography.SHA256]::Create()
// $bytes = [System.Text.Encoding]::UTF8.GetBytes('your chosen password')
// ([System.BitConverter]::ToString($sha.ComputeHash($bytes))).Replace('-', '').ToLowerInvariant()
constexpr char DASHBOARD_ADMIN_USER[] = "admin";
constexpr char DASHBOARD_PASSWORD_SHA256[] = "REPLACE_WITH_YOUR_PASSWORD_SHA256_DIGEST";
