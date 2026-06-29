#!/usr/bin/env bash
set -Eeuo pipefail

REMOTE="origin"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

git rev-parse --is-inside-work-tree >/dev/null || {
    echo "Not a git repository."
    exit 1
}

BRANCH=$(git branch --show-current)

echo "Repository : $REPO_DIR"
echo "Branch     : $BRANCH"

echo "Fetching..."

git fetch --prune "$REMOTE"

echo "Checking for conflicting untracked files..."

git ls-files --others --exclude-standard | while IFS= read -r file; do
    if git cat-file -e "$REMOTE/$BRANCH:$file" 2>/dev/null; then
        echo "Removing conflicting untracked file: $file"
        rm -rf -- "$file"
    fi
done

LOCAL=$(git rev-parse HEAD)
REMOTE_HEAD=$(git rev-parse "$REMOTE/$BRANCH")

if [[ "$LOCAL" != "$REMOTE_HEAD" ]]; then
    echo "Updating repository..."
    git reset --hard "$REMOTE/$BRANCH"
else
    echo "Already up-to-date."
fi

echo "Done."
