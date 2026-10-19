#!/usr/bin/env bash
# Antigravity Skills Installer for Linux / macOS

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"

TARGET_DIR="${HOME}/.gemini/config/skills"

if [[ "${1:-}" == "--workspace" || "${1:-}" == "-w" ]]; then
    TARGET_DIR="$(pwd)/.agents/skills"
fi

echo "==> Installing Antigravity Skills to: $TARGET_DIR"
mkdir -p "$TARGET_DIR"

for skill in owl battle benchmark compaction; do
    if [[ -d "$SKILLS_SRC/$skill" ]]; then
        cp -r "$SKILLS_SRC/$skill" "$TARGET_DIR/"
        echo "  [OK] Installed skill: /$skill"
    fi
done

echo ""
echo "All skills installed successfully!"
echo "Restart your Antigravity session or reload your IDE window to access the new slash commands."
