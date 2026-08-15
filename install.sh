#!/usr/bin/env bash
set -e

echo "⚡ Installing FluxNat Proxy Skill (/proxy) for AI Agents..."

SKILL_URL="https://raw.githubusercontent.com/k4ran909/proxy/main/skills/proxy/SKILL.md"

# Target directories to install skill
TARGET_DIRS=(
  "$HOME/.gemini/config/skills/proxy"
  "$HOME/.hermes/skills/proxy"
  "$(pwd)/.agents/skills/proxy"
)

INSTALLED=0

for DIR in "${TARGET_DIRS[@]}"; do
  mkdir -p "$DIR"
  if curl -fsSL "$SKILL_URL" -o "$DIR/SKILL.md"; then
    echo "✅ Installed skill to: $DIR/SKILL.md"
    INSTALLED=$((INSTALLED + 1))
  fi
done

if [ "$INSTALLED" -gt 0 ]; then
  echo ""
  echo "🎉 Success! The /proxy skill is installed and ready."
  echo "👉 You can now tell any agent: '/proxy' or 'use proxy skill to scrape X'"
else
  echo "❌ Installation failed. Please check your internet connection."
  exit 1
fi
