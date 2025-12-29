# Git LFS Migration Guide

## Setup Complete ✅

Git LFS has been successfully configured for the following asset directories:
- `assets/css/**`
- `assets/icons/**` (16MB+, 4500+ SVG files)
- `assets/images/**`
- `assets/js/**`
- `assets/vendor-css/**`
- `assets/vendor-js/**`

## Verification

The setup has been verified:
```bash
git check-attr filter assets/css/admin-main.min.css
# Output: assets/css/admin-main.min.css: filter: lfs

git check-attr filter assets/icons/font-awesome/regular.svg
# Output: assets/icons/font-awesome/regular.svg: filter: lfs

git check-attr filter assets/js/admin-main.min.js
# Output: assets/js/admin-main.min.js: filter: lfs
```

## Migration Options

### ⚠️ Important Notes

- **New files** in tracked directories will automatically use Git LFS
- **Existing files** in the repository need to be migrated
- Migration rewrites git history, so coordinate with your team
- Create a backup branch before migrating: `git branch backup-before-lfs-migration`

### Option 1: Migrate Current Branch Only (Recommended - Safe)

This option migrates only files in the current branch (HEAD). It's safer and faster.

```bash
# 1. Ensure you're on the branch you want to migrate
git checkout main  # or your main branch name

# 2. Migrate each directory separately (recommended for better control)
git lfs migrate import --include="assets/css/**" --everything
git lfs migrate import --include="assets/icons/**" --everything
git lfs migrate import --include="assets/images/**" --everything
git lfs migrate import --include="assets/js/**" --everything
git lfs migrate import --include="assets/vendor-css/**" --everything
git lfs migrate import --include="assets/vendor-js/**" --everything

# 3. Verify migration
git lfs ls-files

# 4. Force push (⚠️ Coordinate with team first!)
# git push --force-with-lease origin main
```

### Option 2: Migrate All Branches (Full History)

This option migrates the entire git history across all branches. **Use with caution!**

```bash
# 1. Create a backup branch
git branch backup-before-lfs-migration

# 2. Migrate all branches (this rewrites history)
git lfs migrate import --include="assets/css/**" --everything
git lfs migrate import --include="assets/icons/**" --everything
git lfs migrate import --include="assets/images/**" --everything
git lfs migrate import --include="assets/js/**" --everything
git lfs migrate import --include="assets/vendor-css/**" --everything
git lfs migrate import --include="assets/vendor-js/**" --everything

# 3. Verify migration
git lfs ls-files

# 4. Force push all branches (⚠️ Coordinate with team first!)
# git push --all --force-with-lease
```

### Option 3: Migrate Single Directory at a Time (Incremental)

If you want to migrate directories one at a time for testing:

```bash
# Migrate icons first (largest directory)
git lfs migrate import --include="assets/icons/**" --everything

# Verify and test
git lfs ls-files | grep "assets/icons"

# If successful, continue with other directories
git lfs migrate import --include="assets/css/**" --everything
git lfs migrate import --include="assets/images/**" --everything
# ... continue with remaining directories
```

## Post-Migration Steps

### 1. Verify Migration

```bash
# List all LFS-tracked files
git lfs ls-files

# Check repository size (should be reduced)
git count-objects -vH
```

### 2. Update Team Members

After migration, team members need to:

```bash
# Option A: Fresh clone (recommended)
git clone <repository-url>
cd directorist
git lfs pull

# Option B: Update existing clone
git fetch origin
git reset --hard origin/main  # or your branch name
git lfs pull
```

### 3. Verify LFS Files

```bash
# Check if files are LFS pointers
git lfs ls-files

# Verify a specific file
file assets/icons/font-awesome/regular.svg
# Should show: Git LFS pointer
```

## Troubleshooting

### Issue: Files not tracked by LFS after migration

**Solution:**
```bash
# Re-check attributes
git check-attr filter assets/css/admin-main.min.css

# If not showing 'lfs', re-track
git lfs track "assets/css/**"
git add .gitattributes
git commit -m "Re-track assets/css with LFS"
```

### Issue: Repository size not reduced

**Solution:**
- Ensure migration completed successfully
- Check that old objects are garbage collected:
  ```bash
  git reflog expire --expire=now --all
  git gc --prune=now --aggressive
  ```

### Issue: Team members can't clone

**Solution:**
- Ensure Git LFS is installed on their machines: `git lfs version`
- They need to run `git lfs install` once
- Use `git lfs pull` after cloning

## Expected Results

- **Repository size**: 315MB → ~50-100MB (60-70% reduction)
- **All large assets**: Tracked by Git LFS
- **Clone time**: Significantly reduced
- **Build artifacts**: Excluded from git (handled by .gitignore)

## Files Modified

1. **.gitattributes**: Added LFS tracking patterns (preserved all export-ignore rules)
2. **.gitignore**: Added exclusions for build artifacts (non-minified JS/CSS)

## Husky Integration

**Note**: No Husky configuration was found (`.husky/` directory doesn't exist), so no Husky integration was needed. If you add Husky later, Git LFS hooks are already installed via `git lfs install`.

---

**Next Steps:**
1. Review the migration options above
2. Choose the migration strategy that fits your workflow
3. Coordinate with your team before force-pushing
4. Test the migration on a feature branch first if possible

