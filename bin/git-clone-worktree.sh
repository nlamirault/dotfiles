#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${1:-}"
BRANCH="${2:-}"

if [[ -z "$REPO_URL" || -z "$BRANCH" ]]; then
  echo "Usage: $(basename "$0") <git-repository> <principal-branch>"
  exit 1
fi

# Derive directory name from repository URL (strip .git suffix)
REPO_NAME=$(basename "$REPO_URL" .git)

if [[ -d "$REPO_NAME" ]]; then
  echo "Error: directory '$REPO_NAME' already exists."
  exit 1
fi

echo "Creating directory: $REPO_NAME"
mkdir "$REPO_NAME"
cd "$REPO_NAME"

# Clone bare into a hidden .bare directory
echo "Cloning bare repository..."
git clone --bare "$REPO_URL" .bare

# Point the directory root to the bare repo so git commands work here
echo "gitdir: ./.bare" > .git

# Enable remote tracking for all branches (bare clones skip this by default)
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# Fetch all remote branches
git fetch --all

# Create the first worktree for the principal branch
echo "Creating worktree for branch: $BRANCH"
git worktree add "$BRANCH" "$BRANCH"

pushd "$BRANCH" > /dev/null
git branch --set-upstream-to="origin/$BRANCH" "$BRANCH"
popd > /dev/null

echo "Done. Worktree ready at: $REPO_NAME/$BRANCH"
