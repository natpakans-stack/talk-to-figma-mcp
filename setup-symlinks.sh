#!/bin/bash
# setup-symlinks.sh
# Creates symlinks from this repo's .md files → ~/.claude/commands/
# so Claude always reads the latest content from the repo.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/src/content/skills"
REFS_SRC="$SCRIPT_DIR/src/content/references"
COMMANDS_DIR="$HOME/.claude/commands"
REFS_DIR="$COMMANDS_DIR/references"

echo "=== Talk to Figma MCP — Symlink Setup ==="
echo ""

# Ensure target dirs exist
mkdir -p "$COMMANDS_DIR"
mkdir -p "$REFS_DIR"

# ── Skills ──────────────────────────────────────────────
echo "📁 Skills:"
for f in "$SKILLS_SRC"/*.md; do
  name=$(basename "$f")
  target="$COMMANDS_DIR/$name"

  if [ -L "$target" ]; then
    echo "  ↩ $name (symlink exists, skipping)"
  elif [ -f "$target" ]; then
    backup="$target.bak"
    echo "  📦 $name → backed up to $name.bak"
    mv "$target" "$backup"
    ln -s "$f" "$target"
    echo "  ✅ $name → symlinked"
  else
    ln -s "$f" "$target"
    echo "  ✅ $name → symlinked"
  fi
done

echo ""

# ── References ──────────────────────────────────────────
echo "📁 References:"
for f in "$REFS_SRC"/*.md; do
  name=$(basename "$f")
  target="$REFS_DIR/$name"

  if [ -L "$target" ]; then
    echo "  ↩ $name (symlink exists, skipping)"
  elif [ -f "$target" ]; then
    backup="$target.bak"
    echo "  📦 $name → backed up to $name.bak"
    mv "$target" "$backup"
    ln -s "$f" "$target"
    echo "  ✅ $name → symlinked"
  else
    ln -s "$f" "$target"
    echo "  ✅ $name → symlinked"
  fi
done

echo ""
echo "✅ Done! Verify with:"
echo "  ls -la ~/.claude/commands/*.md"
echo "  ls -la ~/.claude/commands/references/*.md"
