# Vision Session Prototype

This is a Codex-ready, adult-only **non-diagnostic** prototype for guided visual-awareness sessions. It is designed on Windows and can later be placed in GitHub and built for iPhone by Codemagic after the required iOS signing configuration is supplied.

It includes two interactive demo flows:

- **Follow the dot** — a timed moving-dot exercise with a session-complete screen.
- **See far away** — a timed large-symbol practice flow that records only in-session answers.

It does **not** diagnose lazy eye, determine a prescription, measure visual acuity, or replace an eye-care professional. The prototype does not save camera, microphone, or health data.

## Choose the development path first

| Your access | What you can do now | What is needed for an IPA |
| --- | --- | --- |
| Windows only | Build and test the Godot prototype on Windows; keep source and design work in this repo. | A macOS CI build such as Codemagic, plus Apple signing credentials. |
| Mac available | Build, test, archive, sign, and export from the same machine. | Xcode, the iOS export tools, and the appropriate Apple Developer signing setup. |

Apple's Xcode documentation describes exporting an archived iOS app as an `.ipa`; it also documents Xcode's supported macOS versions. See [exporting an IPA](https://developer.apple.com/documentation/xcode/distributing-your-app-to-registered-devices) and [Xcode system requirements](https://developer.apple.com/xcode/system-requirements/).

## Quick start

1. Read [`docs/SAFETY_SCOPE.md`](docs/SAFETY_SCOPE.md).
2. Install Godot 4.x on the computer you use for development.
3. Import the [`game`](game) folder into Godot and run it on desktop.
4. Choose either demo mode and complete the session with mouse/touch input.

## iOS export

### If you have a Mac

1. Push this source folder to a GitHub repository.
2. Add the repository in Codemagic and use a macOS workflow.
3. Configure a Godot iOS export preset and a unique bundle identifier.
4. Add Apple signing assets only in Codemagic's secure signing settings; never commit them.
5. Export a signed IPA only after the macOS build and signing configuration succeed.

### If you only have Windows today

Develop and test the Godot prototype locally. Do **not** expect Windows to produce a signed iOS IPA by itself. Keep the source portable, then use Codemagic's macOS builders when the prototype is ready for device testing.

- use a Mac you control;
- give the repository to a trusted teammate with a Mac; or
- configure a macOS CI service with Apple signing credentials stored as repository secrets.

The [`docs/IOS_HANDOFF.md`](docs/IOS_HANDOFF.md) checklist keeps that handoff predictable.

## Layout

- `game/` — Godot project and prototype source.
- `docs/` — safety scope, platform decision, iOS handoff, and Codex work queue.
- `scripts/` — Mac-only export helper.
- `tests/` — place automated gameplay/unit tests here as the game grows.
- `AGENTS.md` — durable guidance for Codex chats working in this repository.

## Safety

Never commit `*.p12`, `*.mobileprovision`, API keys, signing passwords, camera images, or microphone recordings. Generated exports belong in `build/`, which is ignored by Git.
