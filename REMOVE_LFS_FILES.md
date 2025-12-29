# How to Remove Git LFS Files

## Methods to Remove Git LFS Files

### Method 1: Remove LFS Tracking (Keep Files as Regular Files)

#### Step 1: Remove from .gitattributes
```bash
# Edit .gitattributes and remove LFS tracking lines
# Remove lines like:
# assets/css/** filter=lfs diff=lfs merge=lfs -text
```

#### Step 2: Migrate Files Back to Regular Git
```bash
# Migrate files from LFS to regular git
git lfs migrate export --include="assets/css/**" --everything
git lfs migrate export --include="assets/js/**" --everything
git lfs migrate export --include="assets/images/**" --everything
git lfs migrate export --include="assets/icons/**" --everything
git lfs migrate export --include="assets/vendor-css/**" --everything
git lfs migrate export --include="assets/vendor-js/**" --everything
```

#### Step 3: Update .gitattributes
```bash
# Remove LFS tracking patterns from .gitattributes
# Keep only export-ignore rules
```

#### Step 4: Commit Changes
```bash
git add .gitattributes
git commit -m "Remove Git LFS tracking"
git push
```

---

### Method 2: Remove LFS Files Completely (Delete from Repository)

#### Option A: Remove from Current Branch Only
```bash
# 1. Remove files
rm -rf assets/css/** assets/js/** assets/images/** assets/icons/** assets/vendor-css/** assets/vendor-js/**

# 2. Remove from git
git rm -r assets/css assets/js assets/images assets/icons assets/vendor-css assets/vendor-js

# 3. Commit
git commit -m "Remove LFS files"
git push
```

#### Option B: Remove from Entire History (⚠️ Destructive)
```bash
# 1. Remove LFS tracking from .gitattributes
# Edit .gitattributes and remove LFS patterns

# 2. Use git filter-branch or BFG to remove from history
# (This rewrites history - be careful!)

# 3. Force push
git push --force-with-lease
```

---

### Method 3: Stop Tracking Specific Files/Directories

#### Remove Specific Pattern from .gitattributes
```bash
# 1. Edit .gitattributes
# Remove the line: assets/css/** filter=lfs diff=lfs merge=lfs -text

# 2. Untrack from LFS
git lfs untrack "assets/css/**"

# 3. Remove from .gitattributes
# Delete the tracking line

# 4. Commit
git add .gitattributes
git commit -m "Stop tracking assets/css with LFS"
```

---

### Method 4: Clean Up LFS Storage

#### Remove Unused LFS Objects
```bash
# Prune old LFS objects
git lfs prune

# Prune with verification
git lfs prune --verify-remote

# Prune older than specific date
git lfs prune --older-than 30d
```

---

## Step-by-Step: Complete LFS Removal

### Step 1: Backup (Important!)
```bash
git branch backup-before-lfs-removal
```

### Step 2: Export LFS Files to Regular Git
```bash
# Export all LFS files to regular git
git lfs migrate export --include="assets/**" --everything
```

### Step 3: Remove LFS Tracking from .gitattributes
```bash
# Edit .gitattributes
# Remove all lines with "filter=lfs"
```

### Step 4: Untrack from LFS
```bash
git lfs untrack "assets/css/**"
git lfs untrack "assets/js/**"
git lfs untrack "assets/images/**"
git lfs untrack "assets/icons/**"
git lfs untrack "assets/vendor-css/**"
git lfs untrack "assets/vendor-js/**"
```

### Step 5: Commit Changes
```bash
git add .gitattributes
git commit -m "Remove Git LFS tracking"
```

### Step 6: Clean Up
```bash
# Remove LFS hooks (optional)
rm -rf .git/hooks/pre-push .git/hooks/post-checkout .git/hooks/post-commit .git/hooks/post-merge

# Prune LFS objects
git lfs prune
```

---

## Quick Commands

### Remove LFS Tracking Only:
```bash
# 1. Edit .gitattributes - remove LFS lines
# 2. Untrack
git lfs untrack "assets/**"
# 3. Commit
git add .gitattributes && git commit -m "Remove LFS tracking"
```

### Export LFS to Regular Git:
```bash
git lfs migrate export --include="assets/**" --everything
```

### Remove Files Completely:
```bash
git rm -r assets/css assets/js assets/images assets/icons assets/vendor-css assets/vendor-js
git commit -m "Remove LFS files"
```

---

## Important Notes

### ⚠️ Warnings:
1. **Export before removing** - Files will be converted to regular git files
2. **Backup first** - Always create a backup branch
3. **History rewrite** - `git lfs migrate export` rewrites history
4. **Team coordination** - Inform team before force pushing

### ✅ Safe Removal:
1. Create backup branch
2. Export LFS files to regular git
3. Remove LFS tracking from .gitattributes
4. Test before pushing
5. Coordinate with team

---

## Summary

**Remove LFS Tracking (Keep Files):**
```bash
git lfs migrate export --include="assets/**" --everything
# Edit .gitattributes - remove LFS lines
git add .gitattributes && git commit -m "Remove LFS"
```

**Remove Files Completely:**
```bash
git rm -r assets/css assets/js assets/images assets/icons assets/vendor-css assets/vendor-js
git commit -m "Remove LFS files"
```

**Stop Tracking Specific:**
```bash
git lfs untrack "assets/css/**"
# Remove from .gitattributes
git add .gitattributes && git commit -m "Stop LFS tracking"
```

