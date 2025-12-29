# Merge Conflict Resolution Guide

## Problem
Local repository has files tracked by Git LFS (pointers), but remote has regular files. This creates conflicts when merging.

## Solution Options

### Option 1: Keep Local (LFS) Version (Recommended)
Since you've set up Git LFS locally, keep your LFS-tracked files:

```bash
# Abort current merge (if any)
git merge --abort

# Merge accepting local (ours) version
git pull origin main --allow-unrelated-histories --strategy-option=ours

# Or manually:
git fetch origin
git merge origin/main --allow-unrelated-histories -X ours
```

### Option 2: Accept Remote Version (Then migrate to LFS)
If you want to start fresh from remote:

```bash
# Abort current merge
git merge --abort

# Reset to remote
git fetch origin
git reset --hard origin/main

# Then set up LFS again
git lfs track "assets/css/**"
git lfs track "assets/icons/**"
git lfs track "assets/images/**"
git lfs track "assets/js/**"
git lfs track "assets/vendor-css/**"
git lfs track "assets/vendor-js/**"
git add .gitattributes
git commit -m "Setup Git LFS"
```

### Option 3: Manual Conflict Resolution (For specific files)
If you want to keep some local and some remote:

```bash
# After merge conflicts
git status

# For each conflicted file, choose:
# Keep local (LFS):
git checkout --ours <file>
git add <file>

# Keep remote:
git checkout --theirs <file>
git add <file>

# Then commit
git commit -m "Resolve merge conflicts"
```

## Recommended Approach

Since you've already set up Git LFS locally, use **Option 1** to keep your LFS setup:

```bash
git merge --abort  # If merge is in progress
git fetch origin
git merge origin/main --allow-unrelated-histories -X ours
git commit -m "Merge remote with local LFS setup"
git push
```

This will:
- Keep your LFS-tracked files
- Merge remote changes for other files
- Preserve your Git LFS configuration

