# Project guidance for Codex

## Mission

Build an adult-only, non-diagnostic visual-awareness prototype. The app may guide a user through a moving-dot session and a large-symbol distance-practice session, but must not diagnose, screen for, treat, or claim to detect eye conditions.

## Start every task by checking

1. `docs/SAFETY_SCOPE.md` for the medical and privacy boundaries.
2. `docs/CODEX_TASKS.md` for the next small, independently testable outcome.
3. `README.md` before changing iOS export or signing files.

The primary development environment is Windows. Codemagic/macOS is reserved for final signed iOS builds.

## Engineering rules

- Use Godot 4.x and GDScript unless the user explicitly approves a different engine.
- Keep prototype logic inside `game/` and make it runnable on Windows/macOS desktop before adding iOS-specific code.
- Use plain, non-medical labels such as “session” and “practice”. Do not calculate or display clinical scores, pass/fail results, conditions, prescriptions, or treatment guidance.
- Treat camera and microphone data as sensitive. Do not persist it. Do not implement recording or upload without explicit user authorization and a reviewed privacy design.
- Do not add signing credentials, provisioning profiles, certificates, or secret values to the repository.
- Do not claim an IPA has been produced unless a Mac-based archive/export actually succeeded.
- Prefer a small playable change with a clear test note over a broad rewrite.

## Verification

- For prototype edits, run the game from the Godot editor and verify the touched interaction.
- For iOS export changes, run `scripts/build-ios.sh` only on macOS with Godot, Xcode, and signing configuration available.
- Record any platform limitation or manual Mac step in `docs/IOS_HANDOFF.md`.
