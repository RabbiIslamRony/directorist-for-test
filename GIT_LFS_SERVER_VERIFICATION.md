# Git LFS Server Verification & File Management

## আপনার প্রশ্নের উত্তর

### ✅ হ্যাঁ, আপনার বোঝাপড়া ঠিক আছে!

যদি আপনি:
1. File গুলো remove করেন
2. Push করেন
3. তারপর Pull করেন

তাহলে **file গুলো থাকবে না** - এটা স্বাভাবিক behavior।

---

## Server-এ File আছে কিনা Verify করা

### Method 1: Remote থেকে Check করা

```bash
# Remote repository-তে LFS files আছে কিনা check করুন
git lfs ls-remote origin

# Specific branch check করতে
git lfs ls-remote origin main

# Specific directory check করতে
git lfs ls-remote origin --include="assets/icons/**"
```

### Method 2: Clone করে Test করা

```bash
# Temporary directory-তে test clone করুন
cd /tmp  # or any temp location
git clone <repository-url> test-clone
cd test-clone
git lfs pull

# Check করুন file গুলো আছে কিনা
ls -la assets/icons/font-awesome/ | head -10

# Cleanup
cd ..
rm -rf test-clone
```

### Method 3: Git LFS Status Check

```bash
# Current repository-তে LFS files check করুন
git lfs ls-files

# Remote-তে আছে কিনা verify করুন
git fetch origin
git lfs fetch origin
git lfs ls-files
```

---

## File Remove করার পর কি হবে?

### Scenario 1: File Delete করে Push করা

```bash
# File delete করুন
rm assets/icons/font-awesome/regular.svg
git add assets/icons/font-awesome/regular.svg
git commit -m "Remove file"
git push

# অন্য কেউ pull করলে file থাকবে না
# এটা স্বাভাবিক - আপনি intentionally delete করেছেন
```

### Scenario 2: Accidental Delete (Recovery)

যদি accidentally delete করে push করে ফেলেন:

```bash
# Option 1: Git history থেকে recover করুন
git log --all --full-history -- assets/icons/font-awesome/regular.svg
git checkout <commit-hash>^ -- assets/icons/font-awesome/regular.svg
git add assets/icons/font-awesome/regular.svg
git commit -m "Restore deleted file"
git push

# Option 2: Previous commit থেকে restore
git checkout HEAD~1 -- assets/icons/font-awesome/regular.svg
git add assets/icons/font-awesome/regular.svg
git commit -m "Restore deleted file"
git push
```

---

## Server-এ File Upload করা Verify করা

### Step 1: Push করার পর Verify

```bash
# File add করুন
git add assets/icons/font-awesome/new-icon.svg
git commit -m "Add new icon"
git push

# Verify করুন remote-তে আছে
git lfs ls-remote origin --include="assets/icons/font-awesome/new-icon.svg"
```

### Step 2: Fresh Clone করে Test করুন

```bash
# অন্য directory-তে test করুন
cd ..
mkdir test-verify
cd test-verify
git clone <repository-url> .
git lfs install
git lfs pull

# Check করুন file আছে
ls assets/icons/font-awesome/new-icon.svg
```

---

## Important Commands for Verification

### Check LFS Files on Remote

```bash
# All LFS files on remote
git lfs ls-remote origin

# Specific branch
git lfs ls-remote origin main

# Specific pattern
git lfs ls-remote origin --include="assets/**"
```

### Check LFS Files Locally

```bash
# List all LFS-tracked files
git lfs ls-files

# Check specific file
git lfs pointer --file=assets/icons/font-awesome/regular.svg

# Verify file is LFS-tracked
git check-attr filter assets/icons/font-awesome/regular.svg
```

### Force Pull LFS Files

```bash
# Pull all LFS files from remote
git lfs fetch --all
git lfs checkout

# Or pull specific files
git lfs pull --include="assets/icons/**"
```

---

## Best Practices

### ✅ DO (করা উচিত)

1. **Push করার আগে verify করুন:**
   ```bash
   git lfs ls-files
   git push
   git lfs ls-remote origin  # Verify on remote
   ```

2. **Important files backup রাখুন:**
   ```bash
   # Before major changes
   git branch backup-$(date +%Y%m%d)
   ```

3. **Team members-কে inform করুন:**
   - যদি large files delete করেন
   - Migration করার আগে

### ❌ DON'T (করা উচিত নয়)

1. **Force push without backup:**
   ```bash
   # Avoid unless necessary
   git push --force
   ```

2. **Delete files without checking:**
   ```bash
   # Always check what you're deleting
   git status
   git diff --cached
   ```

---

## Recovery Options

### যদি File Delete হয়ে যায়

#### Option 1: Git History থেকে Recover

```bash
# Find when file existed
git log --all --full-history -- "assets/icons/font-awesome/regular.svg"

# Restore from specific commit
git checkout <commit-hash>^ -- "assets/icons/font-awesome/regular.svg"
git add .
git commit -m "Restore deleted file"
git push
```

#### Option 2: Reflog থেকে Recover

```bash
# Find deleted file in reflog
git reflog
git checkout <reflog-hash> -- "assets/icons/font-awesome/regular.svg"
```

#### Option 3: Remote থেকে Pull

```bash
# যদি remote-তে file থাকে
git fetch origin
git checkout origin/main -- "assets/icons/font-awesome/regular.svg"
```

---

## Verification Checklist

Before considering files "safe on server":

- [ ] `git push` successful হয়েছে
- [ ] `git lfs ls-remote origin` command-এ files দেখা যাচ্ছে
- [ ] Fresh clone করে file গুলো pull করা যায়
- [ ] `git lfs pull` command কাজ করছে
- [ ] Team members fresh clone করে file পাচ্ছে

---

## Quick Verification Script

### Windows (PowerShell/Bash)

```bash
# verify-lfs-files.sh

echo "=== Git LFS Verification ==="
echo ""
echo "1. Checking Git LFS files on remote..."
git lfs ls-remote origin | head -10

echo ""
echo "2. Checking local LFS files..."
git lfs ls-files | head -10

echo ""
echo "3. Testing specific files..."
git check-attr filter assets/css/admin-main.min.css
git check-attr filter assets/js/admin-main.min.js

echo ""
echo "4. Repository status..."
git status --short | head -5

echo ""
echo "=== Verification complete! ==="
```

### Run Verification

```bash
# Save as verify-lfs.sh and run
chmod +x verify-lfs.sh
./verify-lfs.sh

# Or run directly
bash verify-lfs.sh
```

---

## Summary (সংক্ষিপ্ত)

### আপনার প্রশ্নের উত্তর:

**Q: File remove করে push করলে pull করলে file থাকবে না?**
- ✅ **হ্যাঁ, এটা ঠিক** - এটা স্বাভাবিক behavior
- File intentionally delete করলে থাকবে না

**Q: Server-এ file আছে কিনা verify করবো কিভাবে?**
- `git lfs ls-remote origin` - Remote-তে files check করুন
- Fresh clone করে test করুন
- `git lfs pull` করে verify করুন

**Q: Accidental delete হলে কি করবো?**
- Git history থেকে recover করুন
- `git checkout <commit> -- <file>` ব্যবহার করুন
- Reflog থেকে restore করুন

---

## Important Notes

1. **Git LFS files server-এ store হয়** - কিন্তু delete করলে remove হয়ে যায়
2. **History থেকে recover করা যায়** - যদি commit করা থাকে
3. **Always verify after push** - `git lfs ls-remote` ব্যবহার করুন
4. **Backup important files** - Before major deletions

