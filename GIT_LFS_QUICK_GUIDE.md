# Git LFS Quick Guide - Server Verification

## আপনার প্রশ্ন: File Remove করে Push করলে কি হবে?

### ✅ আপনার বোঝাপড়া ১০০% ঠিক!

**Scenario:**
```bash
# 1. File delete করুন
rm assets/css/admin-main.min.css
git add assets/css/admin-main.min.css
git commit -m "Delete file"
git push

# 2. Pull করুন
git pull

# 3. Result: File থাকবে না ✅
```

**এটা স্বাভাবিক behavior** - আপনি intentionally file delete করলে, সেটা server থেকেও remove হয়ে যাবে।

---

## Server-এ File আছে কিনা Verify করা

### Method 1: Quick Check (সবচেয়ে সহজ)

```bash
# Remote-তে LFS files check করুন
git lfs ls-remote origin

# Output দেখাবে সব LFS files যা remote-তে আছে
```

### Method 2: Test Clone (সবচেয়ে নির্ভরযোগ্য)

```bash
# Temporary location-এ test clone করুন
cd ..
mkdir test-verify
cd test-verify
git clone https://github.com/RabbiIslamRony/directorist-for-test.git .
git lfs install
git lfs pull

# Check করুন file আছে
ls assets/css/admin-main.min.css

# Cleanup
cd ..
rm -rf test-verify
cd directorist
```

### Method 3: Verification Script

```bash
# Run verification script
bash verify-lfs-files.sh
```

---

## Practical Example: Step by Step

### Step 1: Push করার আগে Verify

```bash
# Check করুন কি push হবে
git status
git lfs ls-files

# Push করুন
git add .
git commit -m "Add files"
git push
```

### Step 2: Push করার পর Verify

```bash
# Remote-তে check করুন
git lfs ls-remote origin

# Specific file check
git lfs ls-remote origin --include="assets/css/admin-main.min.css"
```

### Step 3: Fresh Clone করে Test

```bash
# অন্য directory-তে test করুন
cd ..
git clone https://github.com/RabbiIslamRony/directorist-for-test.git test-clone
cd test-clone
git lfs install
git lfs pull

# File আছে কিনা check করুন
ls assets/css/admin-main.min.css
```

---

## File Delete করার পর Recovery

### যদি Accidental Delete হয়ে যায়:

```bash
# Option 1: Git history থেকে recover
git log --all --full-history -- "assets/css/admin-main.min.css"
git checkout <commit-hash>^ -- "assets/css/admin-main.min.css"
git add .
git commit -m "Restore deleted file"
git push

# Option 2: Previous commit থেকে
git checkout HEAD~1 -- "assets/css/admin-main.min.css"
git add .
git commit -m "Restore file"
git push
```

---

## Important Commands

### Verify Files on Server

```bash
# Remote-তে সব LFS files
git lfs ls-remote origin

# Specific branch
git lfs ls-remote origin main

# Specific directory
git lfs ls-remote origin --include="assets/css/**"
```

### Verify Files Locally

```bash
# Local LFS files
git lfs ls-files

# Check specific file
git check-attr filter assets/css/admin-main.min.css
```

### Force Pull LFS Files

```bash
# সব LFS files pull করুন
git lfs fetch --all
git lfs checkout
```

---

## Summary (সংক্ষিপ্ত উত্তর)

### Q: File remove করে push করলে pull করলে file থাকবে না?
**A: ✅ হ্যাঁ, ঠিক আছে** - এটা স্বাভাবিক। Delete করলে file remove হবে।

### Q: Server-এ file আছে কিনা verify করবো কিভাবে?
**A: 3টি method:**
1. `git lfs ls-remote origin` - Quick check
2. Fresh clone করে test - সবচেয়ে reliable
3. `bash verify-lfs-files.sh` - Automated check

### Q: Accidental delete হলে কি করবো?
**A: Git history থেকে recover:**
```bash
git checkout <commit> -- <file>
```

---

## Checklist: Before Push

- [ ] `git status` check করেছেন
- [ ] `git lfs ls-files` দেখেছেন
- [ ] Important files backup করেছেন
- [ ] `git push` successful হয়েছে
- [ ] `git lfs ls-remote origin` verify করেছেন

---

## Quick Test Command

```bash
# সব verification একসাথে
echo "=== Verification ===" && \
git lfs ls-remote origin | head -5 && \
echo "" && \
echo "Local files:" && \
git lfs ls-files | head -5
```

