#!/usr/bin/env bash
set -Eeuo pipefail

# Configuration
REMOTE="origin"

# Repository root (script lives in the repo)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

# Verify repository
git rev-parse --is-inside-work-tree >/dev/null || {
    echo "Error: Not a git repository."
    exit 1
}

# Auto-detect Samba SYSVOL scripts directory
mapfile -t TARGETS < <(
    find /var/lib/samba/sysvol \
        -mindepth 2 -maxdepth 2 \
        -type d -name scripts
)

case "${#TARGETS[@]}" in
    0)
        echo "Error: No SYSVOL scripts directory found."
        exit 1
        ;;
    1)
        TARGET="${TARGETS[0]}"
        ;;
    *)
        echo "Error: Multiple SYSVOL scripts directories found:"
        printf ' - %s\n' "${TARGETS[@]}"
        exit 1
        ;;
esac

BRANCH=$(git branch --show-current)

echo "Repository : $REPO_DIR"
echo "Branch     : $BRANCH"
echo "Target     : $TARGET"

echo "Updating repository..."

git fetch --prune "$REMOTE"

git rev-parse --verify "$REMOTE/$BRANCH" >/dev/null || {
    echo "Error: Remote branch $REMOTE/$BRANCH not found."
    exit 1
}

LOCAL=$(git rev-parse HEAD)
REMOTE_HEAD=$(git rev-parse "$REMOTE/$BRANCH")

if [[ "$LOCAL" != "$REMOTE_HEAD" ]]; then
    echo "New revision detected."
    git reset --hard "$REMOTE/$BRANCH"
else
    echo "Already up-to-date."
fi

echo "Deploying..."

rsync -arv \
    --exclude='.git/' \
    --exclude="$(basename "$0")" \
    "$REPO_DIR/" "$TARGET/"

echo "Deployment complete."
