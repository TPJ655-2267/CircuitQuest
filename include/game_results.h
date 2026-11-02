#pragma once
#include <Arduino.h>
#include <Preferences.h>

struct CompletedRun {
    uint32_t attempt;
    char playerId[9];
    uint64_t elapsedSeconds;
    uint64_t penaltySeconds;
};

class GameResults {
public:
    static constexpr uint8_t CAPACITY = 50;
    struct Store {
        uint32_t version;
        uint32_t nextAttempt;
        uint8_t count;
        CompletedRun runs[CAPACITY];
    };

    void begin() {
        storageReady = preferences.begin("cq-results", false);
        if (!storageReady) return;
        if (preferences.getBytesLength("runs") != sizeof(Store)) return;
        Store saved = {};
        if (preferences.getBytes("runs", &saved, sizeof(saved)) != sizeof(saved) ||
            saved.version != 1 || saved.count > CAPACITY || saved.nextAttempt == 0) return;
        for (uint8_t i = 0; i < saved.count; ++i) {
            const CompletedRun& run = saved.runs[i];
            if (!run.attempt || run.attempt >= saved.nextAttempt ||
                run.playerId[8] != '\0' || run.playerId[0] == '\0') return;
            for (uint8_t j = 0; run.playerId[j]; ++j) {
                if (run.playerId[j] < '0' || run.playerId[j] > '9') return;
            }
        }
        data = saved;
    }

    void add(const char* player, uint64_t elapsed, uint64_t penalties) {
        if (data.count == CAPACITY) {
            memmove(&data.runs[0], &data.runs[1], sizeof(CompletedRun) * (CAPACITY - 1));
            --data.count;
        }
        CompletedRun run = {};
        run.attempt = data.nextAttempt++;
        strlcpy(run.playerId, player, sizeof(run.playerId));
        run.elapsedSeconds = elapsed;
        run.penaltySeconds = penalties;
        data.runs[data.count++] = run;
        lastSaveOk = storageReady && preferences.putBytes("runs", &data, sizeof(data)) == sizeof(data);
    }

    Store data = {1, 1, 0, {}};
    bool storageReady = false;
    bool lastSaveOk = true;

private:
    Preferences preferences;
};
