#!/usr/bin/env bash

CONFIG_DIR="$HOME/dotfiles"
cd "$CONFIG_DIR" || exit 1

if [[ -n $(git status --porcelain) ]]; then
    echo "$(date): Changes detected, committing and pushing..."
    
    git add .
    git commit -m "Auto-update: $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin main
    
    echo "$(date): Push completed"
else
    echo "$(date): No changes detected"
fi
