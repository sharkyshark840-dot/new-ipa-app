#!/usr/bin/env bash
set -euo pipefail

# Run only on macOS after configuring Godot's iOS export preset and Apple signing.
if [[ "$(uname)" != "Darwin" ]]; then
  echo "iOS export requires a macOS build environment with Xcode."
  exit 1
fi

if ! command -v godot >/dev/null 2>&1; then
  echo "Godot was not found on PATH. Install Godot 4.x and add its executable to PATH."
  exit 1
fi

if ! xcode-select -p >/dev/null 2>&1; then
  echo "Xcode command-line tools are unavailable. Install/open Xcode, then retry."
  exit 1
fi

if [[ ! -f game/export_presets.cfg ]]; then
  echo "No Godot iOS export preset found. Configure one in Godot before exporting."
  exit 1
fi

mkdir -p build/ios
godot --path game --export-release "iOS" "../build/ios/iOSGameStarter.ipa"
echo "Export command completed. Confirm signing and installation on a physical iPhone."
