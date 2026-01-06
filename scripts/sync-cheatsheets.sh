#!/usr/bin/env bash

# ==============================================================================
# Sync Cheatsheets Script
# ==============================================================================
# Syncs cheatsheets from source directory to docs for GitHub Pages deployment
#
# Usage:
#   ./scripts/sync-cheatsheets.sh           # Sync and show status
#   ./scripts/sync-cheatsheets.sh --commit  # Sync, commit, and push
# ==============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
SOURCE_DIR="$DOTFILES_DIR/cheatsheets"
DEST_DIR="$DOTFILES_DIR/docs/cheatsheets"

# Parse arguments
AUTO_COMMIT=false
if [[ "$1" == "--commit" ]]; then
    AUTO_COMMIT=true
fi

echo -e "${BLUE}📚 Syncing Cheatsheets${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check if source directory exists
if [[ ! -d "$SOURCE_DIR" ]]; then
    echo -e "${RED}✗ Error: Source directory not found: $SOURCE_DIR${NC}"
    exit 1
fi

# Create destination directory if it doesn't exist
if [[ ! -d "$DEST_DIR" ]]; then
    echo -e "${YELLOW}⚠ Creating destination directory: $DEST_DIR${NC}"
    mkdir -p "$DEST_DIR"
fi

# Count markdown files
SOURCE_COUNT=$(find "$SOURCE_DIR" -maxdepth 1 -name "*.md" | wc -l | tr -d ' ')

if [[ $SOURCE_COUNT -eq 0 ]]; then
    echo -e "${YELLOW}⚠ No markdown files found in $SOURCE_DIR${NC}"
    exit 0
fi

echo -e "${GREEN}Found $SOURCE_COUNT cheatsheet(s) to sync${NC}"
echo ""

# Sync files
SYNCED=0
UPDATED=0
UNCHANGED=0

for file in "$SOURCE_DIR"/*.md; do
    if [[ -f "$file" ]]; then
        filename=$(basename "$file")
        dest_file="$DEST_DIR/$filename"

        # Check if file exists and compare
        if [[ -f "$dest_file" ]]; then
            if ! cmp -s "$file" "$dest_file"; then
                echo -e "${YELLOW}  ↻ Updating: $filename${NC}"
                cp "$file" "$dest_file"
                UPDATED=$((UPDATED + 1))
            else
                echo -e "${GREEN}  ✓ Unchanged: $filename${NC}"
                UNCHANGED=$((UNCHANGED + 1))
            fi
        else
            echo -e "${BLUE}  + Adding: $filename${NC}"
            cp "$file" "$dest_file"
            SYNCED=$((SYNCED + 1))
        fi
    fi
done

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Sync Complete!${NC}"
echo -e "  ${GREEN}✓${NC} New: $SYNCED"
echo -e "  ${YELLOW}↻${NC} Updated: $UPDATED"
echo -e "  ${GREEN}✓${NC} Unchanged: $UNCHANGED"
echo ""

# Check if we should commit changes
if [[ "$AUTO_COMMIT" == true ]]; then
    cd "$DOTFILES_DIR"

    # Check if there are changes
    if [[ -n $(git status --porcelain docs/cheatsheets/) ]]; then
        echo -e "${BLUE}📝 Committing changes...${NC}"

        git add docs/cheatsheets/

        # Create commit message
        COMMIT_MSG="update: sync cheatsheets to docs"
        if [[ $SYNCED -gt 0 ]]; then
            COMMIT_MSG="$COMMIT_MSG ($SYNCED new"
            [[ $UPDATED -gt 0 ]] && COMMIT_MSG="$COMMIT_MSG, $UPDATED updated"
            COMMIT_MSG="$COMMIT_MSG)"
        elif [[ $UPDATED -gt 0 ]]; then
            COMMIT_MSG="$COMMIT_MSG ($UPDATED updated)"
        fi

        git commit -m "$COMMIT_MSG"

        echo -e "${BLUE}🚀 Pushing to remote...${NC}"
        git push origin main

        echo ""
        echo -e "${GREEN}✓ Changes committed and pushed!${NC}"
        echo -e "${BLUE}ℹ GitHub Pages will deploy in ~1 minute${NC}"
    else
        echo -e "${GREEN}✓ No changes to commit${NC}"
    fi
else
    # Check for uncommitted changes
    cd "$DOTFILES_DIR"
    if [[ -n $(git status --porcelain docs/cheatsheets/) ]]; then
        echo -e "${YELLOW}⚠ Uncommitted changes detected${NC}"
        echo -e "  Run with ${BLUE}--commit${NC} flag to commit and push:"
        echo -e "  ${BLUE}./scripts/sync-cheatsheets.sh --commit${NC}"
    else
        echo -e "${GREEN}✓ All cheatsheets are in sync${NC}"
    fi
fi

echo ""
