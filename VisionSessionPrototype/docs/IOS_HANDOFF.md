# iOS and Codemagic handoff checklist

Use this if day-to-day work happens on Windows but the final iOS build happens in Codemagic's macOS environment.

## Before the handoff

- [ ] The repository is committed and does not contain build output or credentials.
- [ ] `game/` opens and runs on desktop in Godot.
- [ ] The prototype has an application name, icon, version, and unique bundle identifier planned.
- [ ] The Codemagic account has access to the correct Apple Developer team.

## In Codemagic

- [ ] Connect the GitHub repository to a macOS workflow.
- [ ] Install a compatible Godot 4.x version and configure the iOS export preset.
- [ ] Store Apple certificates, provisioning profiles, and passwords in Codemagic's secure signing settings — never in Git.
- [ ] Build and export a signed IPA for the intended test device.
- [ ] Install it only on the provisioned personal iPhone and verify it there.

## After export

- [ ] Keep the IPA outside source control (or publish it only to the approved private release channel).
- [ ] Record the tested Xcode and Godot versions, distribution method, and any manual settings here.
- [ ] Commit only source/configuration changes that are safe to share.

## Build record

| Date | Builder | Xcode | Godot | Distribution | Result |
| --- | --- | --- | --- | --- | --- |
| _not yet built_ |  |  |  |  |  |
