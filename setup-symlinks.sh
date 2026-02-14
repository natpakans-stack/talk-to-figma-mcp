#!/bin/bash
# ──────────────────────────────────────────────────────────────
# setup-symlinks.sh
# สร้าง symlinks จาก repo → ~/.claude/commands/
# ให้ทีม Designer ใช้ Skills & References ร่วมกันผ่าน Git
#
# Usage:
#   bash setup-symlinks.sh            # Install (สร้าง symlinks)
#   bash setup-symlinks.sh --force    # Force re-link ทุกไฟล์
#   bash setup-symlinks.sh --status   # ตรวจสถานะ symlinks
#   bash setup-symlinks.sh --uninstall # ลบ symlinks ทั้งหมด
# ──────────────────────────────────────────────────────────────

set -e

# ── Colors ──
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# ── Paths ──
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/src/content/skills"
REFS_SRC="$SCRIPT_DIR/src/content/references"
COMMANDS_DIR="$HOME/.claude/commands"
REFS_DIR="$COMMANDS_DIR/references"

# ── Parse flags ──
MODE="install"
FORCE=false

for arg in "$@"; do
  case "$arg" in
    --force)    FORCE=true ;;
    --status)   MODE="status" ;;
    --uninstall) MODE="uninstall" ;;
    --help|-h)  MODE="help" ;;
    *)
      echo -e "${RED}Unknown option: $arg${NC}"
      echo "Usage: bash setup-symlinks.sh [--force|--status|--uninstall|--help]"
      exit 1
      ;;
  esac
done

# ── Help ──
if [ "$MODE" = "help" ]; then
  echo ""
  echo -e "${BOLD}Talk to Figma MCP — Symlink Setup${NC}"
  echo ""
  echo "Usage:"
  echo "  bash setup-symlinks.sh            Install symlinks"
  echo "  bash setup-symlinks.sh --force    Force re-link (update existing)"
  echo "  bash setup-symlinks.sh --status   Check symlink status"
  echo "  bash setup-symlinks.sh --uninstall Remove all symlinks"
  echo ""
  echo "After install, skills are available as /skill-name in Claude Code."
  echo ""
  exit 0
fi

# ── Validate source directories ──
if [ ! -d "$SKILLS_SRC" ]; then
  echo -e "${RED}Error: Skills directory not found: $SKILLS_SRC${NC}"
  echo "Make sure you're running this from the repo root."
  exit 1
fi
if [ ! -d "$REFS_SRC" ]; then
  echo -e "${RED}Error: References directory not found: $REFS_SRC${NC}"
  exit 1
fi

# ══════════════════════════════════════════════════════════════
# STATUS
# ══════════════════════════════════════════════════════════════
if [ "$MODE" = "status" ]; then
  echo ""
  echo -e "${BOLD}${CYAN}=== Symlink Status ===${NC}"

  ok=0
  broken=0
  missing=0

  echo ""
  echo -e "${BOLD}Skills:${NC}"
  for f in "$SKILLS_SRC"/*.md; do
    name=$(basename "$f")
    target="$COMMANDS_DIR/$name"
    if [ -L "$target" ]; then
      link_target=$(readlink "$target")
      if [ "$link_target" = "$f" ]; then
        echo -e "  ${GREEN}OK${NC}  $name"
        ok=$((ok + 1))
      else
        echo -e "  ${YELLOW}!!${NC}  $name -> $link_target (expected: $f)"
        broken=$((broken + 1))
      fi
    elif [ -f "$target" ]; then
      echo -e "  ${YELLOW}!!${NC}  $name (regular file, not symlink)"
      broken=$((broken + 1))
    else
      echo -e "  ${RED}--${NC}  $name (not installed)"
      missing=$((missing + 1))
    fi
  done

  echo ""
  echo -e "${BOLD}References:${NC}"
  for f in "$REFS_SRC"/*.md; do
    name=$(basename "$f")
    target="$REFS_DIR/$name"
    if [ -L "$target" ]; then
      link_target=$(readlink "$target")
      if [ "$link_target" = "$f" ]; then
        echo -e "  ${GREEN}OK${NC}  $name"
        ok=$((ok + 1))
      else
        echo -e "  ${YELLOW}!!${NC}  $name -> $link_target (expected: $f)"
        broken=$((broken + 1))
      fi
    elif [ -f "$target" ]; then
      echo -e "  ${YELLOW}!!${NC}  $name (regular file, not symlink)"
      broken=$((broken + 1))
    else
      echo -e "  ${RED}--${NC}  $name (not installed)"
      missing=$((missing + 1))
    fi
  done

  echo ""
  echo -e "Summary: ${GREEN}$ok OK${NC} / ${YELLOW}$broken needs update${NC} / ${RED}$missing missing${NC}"
  if [ $broken -gt 0 ] || [ $missing -gt 0 ]; then
    echo -e "Run ${BOLD}bash setup-symlinks.sh --force${NC} to fix."
  fi
  echo ""
  exit 0
fi

# ══════════════════════════════════════════════════════════════
# UNINSTALL
# ══════════════════════════════════════════════════════════════
if [ "$MODE" = "uninstall" ]; then
  echo ""
  echo -e "${BOLD}${RED}=== Uninstall Symlinks ===${NC}"
  echo ""

  removed=0

  echo -e "${BOLD}Skills:${NC}"
  for f in "$SKILLS_SRC"/*.md; do
    name=$(basename "$f")
    target="$COMMANDS_DIR/$name"
    if [ -L "$target" ]; then
      rm "$target"
      echo -e "  ${RED}Removed${NC}  $name"
      removed=$((removed + 1))
      # Restore backup if exists
      if [ -f "$target.bak" ]; then
        mv "$target.bak" "$target"
        echo -e "  ${GREEN}Restored${NC} $name.bak -> $name"
      fi
    fi
  done

  echo ""
  echo -e "${BOLD}References:${NC}"
  for f in "$REFS_SRC"/*.md; do
    name=$(basename "$f")
    target="$REFS_DIR/$name"
    if [ -L "$target" ]; then
      rm "$target"
      echo -e "  ${RED}Removed${NC}  $name"
      removed=$((removed + 1))
      if [ -f "$target.bak" ]; then
        mv "$target.bak" "$target"
        echo -e "  ${GREEN}Restored${NC} $name.bak -> $name"
      fi
    fi
  done

  echo ""
  echo -e "Removed $removed symlinks."
  echo ""
  exit 0
fi

# ══════════════════════════════════════════════════════════════
# INSTALL
# ══════════════════════════════════════════════════════════════
echo ""
echo -e "${BOLD}${CYAN}=== Talk to Figma MCP — Symlink Setup ===${NC}"
echo ""

# Ensure target dirs exist
mkdir -p "$COMMANDS_DIR"
mkdir -p "$REFS_DIR"

created=0
skipped=0
updated=0
backed_up=0

# ── Helper function ──
link_file() {
  local src="$1"
  local dest="$2"
  local name=$(basename "$src")

  if [ -L "$dest" ]; then
    link_target=$(readlink "$dest")
    if [ "$link_target" = "$src" ] && [ "$FORCE" = false ]; then
      echo -e "  ${BLUE}Skip${NC}  $name (already linked)"
      skipped=$((skipped + 1))
      return
    fi
    # Force or different target: re-link
    rm "$dest"
    ln -s "$src" "$dest"
    echo -e "  ${GREEN}Updated${NC}  $name"
    updated=$((updated + 1))
  elif [ -f "$dest" ]; then
    # Regular file exists — backup then link
    mv "$dest" "$dest.bak"
    ln -s "$src" "$dest"
    echo -e "  ${YELLOW}Backed up${NC}  $name.bak"
    echo -e "  ${GREEN}Linked${NC}    $name"
    backed_up=$((backed_up + 1))
    created=$((created + 1))
  else
    ln -s "$src" "$dest"
    echo -e "  ${GREEN}Linked${NC}  $name"
    created=$((created + 1))
  fi
}

# ── Skills ──
echo -e "${BOLD}Skills:${NC}"
for f in "$SKILLS_SRC"/*.md; do
  [ -f "$f" ] || continue
  link_file "$f" "$COMMANDS_DIR/$(basename "$f")"
done

echo ""

# ── References ──
echo -e "${BOLD}References:${NC}"
for f in "$REFS_SRC"/*.md; do
  [ -f "$f" ] || continue
  link_file "$f" "$REFS_DIR/$(basename "$f")"
done

echo ""
echo -e "${BOLD}Done!${NC} Created: $created / Updated: $updated / Skipped: $skipped / Backed up: $backed_up"
echo ""
echo -e "Verify:  ${CYAN}bash setup-symlinks.sh --status${NC}"
echo -e "Update:  ${CYAN}git pull && bash setup-symlinks.sh --force${NC}"
echo ""
