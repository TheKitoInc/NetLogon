#!/usr/bin/env bash
set -euo pipefail

REMOTE="${1:-origin}"

# Directory where this script resides
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

cd "$SCRIPT_DIR"

# Verify Git repository
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || {
    echo "Error: '$SCRIPT_DIR' is not a Git repository."
    exit 1
}

# Current branch
BRANCH=$(git symbolic-ref --quiet --short HEAD) || {
    echo "Error: Detached HEAD."
    exit 1
}

# Verify remote exists
git remote get-url "$REMOTE" >/dev/null 2>&1 || {
    echo "Error: Remote '$REMOTE' does not exist."
    exit 1
}

echo "Repository : $SCRIPT_DIR"
echo "Branch     : $BRANCH"
echo "Remote     : $REMOTE"

git fetch --prune "$REMOTE"

# Verify remote branch exists
git show-ref --verify --quiet "refs/remotes/$REMOTE/$BRANCH" || {
    echo "Error: Remote branch '$REMOTE/$BRANCH' not found."
    exit 1
}

git reset --hard "$REMOTE/$BRANCH"

echo "Repository synchronized."
echo "Untracked files preserved."
