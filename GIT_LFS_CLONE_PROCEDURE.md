# Git LFS Clone & Setup Procedure

## Fresh Clone (নতুন Clone করার পর)

### Step 1: Clone the Repository
```bash
git clone <repository-url>
cd directorist
```

### Step 2: Install Git LFS (if not already installed)
```bash
# Check if Git LFS is installed
git lfs version

# If not installed, install it:
# Windows: Download from https://git-lfs.github.com/
# macOS: brew install git-lfs
# Linux: sudo apt-get install git-lfs

# Initialize Git LFS (one-time setup per machine)
git lfs install
```

### Step 3: Pull LFS Files
```bash
# Pull all LFS-tracked files
git lfs pull

# Or pull specific directory
git lfs pull --include="assets/icons/**"
```

### Step 4: Verify LFS Files
```bash
# Check if LFS files are downloaded
git lfs ls-files

# Verify a specific file
file assets/icons/font-awesome/regular.svg
# Should show: Git LFS pointer (if not pulled) or actual file (if pulled)
```

---

## Existing Clone Update (আগে থেকে Clone করা থাকলে)

### Option A: Fresh Start (Recommended)
```bash
# Backup your local changes first
git stash  # or commit your changes

# Remove old clone
cd ..
rm -rf directorist  # or delete folder manually

# Clone fresh
git clone <repository-url>
cd directorist
git lfs install
git lfs pull
```

### Option B: Update Existing Clone
```bash
cd directorist

# Install Git LFS if not done
git lfs install

# Fetch latest changes
git fetch origin

# Reset to match remote (⚠️ This will discard local changes)
git reset --hard origin/main  # or your branch name

# Pull LFS files
git lfs pull
```

---

## Daily Workflow (নিত্য কাজের জন্য)

### Normal Git Operations Work Automatically
```bash
# These commands work normally - Git LFS handles files automatically
git add assets/css/admin-main.min.css
git commit -m "Update CSS"
git push

# When pulling
git pull
git lfs pull  # Pull any new LFS files
```

### Check LFS Status
```bash
# See which files are tracked by LFS
git lfs ls-files

# Check if a file is LFS-tracked
git check-attr filter assets/css/admin-main.min.css
# Output: assets/css/admin-main.min.css: filter: lfs
```

---

## Troubleshooting (সমস্যা সমাধান)

### Problem: Files show as "Git LFS pointer" instead of actual files

**Solution:**
```bash
# Pull LFS files
git lfs pull

# Or pull specific directory
git lfs pull --include="assets/icons/**"
```

### Problem: `git lfs: command not found`

**Solution:**
```bash
# Install Git LFS
# Windows: Download installer from https://git-lfs.github.com/
# macOS: brew install git-lfs
# Linux: sudo apt-get install git-lfs

# Then initialize
git lfs install
```

### Problem: Clone is still slow/large

**Solution:**
```bash
# Make sure you're cloning with LFS
git clone <repository-url>
cd directorist
git lfs install
git lfs pull

# If still large, check if migration was done
git lfs ls-files
# If empty, files haven't been migrated yet
```

### Problem: Can't see actual files, only pointers

**Solution:**
```bash
# This is normal - LFS files are stored separately
# Pull them explicitly:
git lfs pull

# Or checkout specific files
git lfs checkout assets/icons/font-awesome/regular.svg
```

---

## Quick Reference Commands

```bash
# One-time setup (per machine)
git lfs install

# After clone
git lfs pull

# Check LFS status
git lfs ls-files

# Pull specific directory
git lfs pull --include="assets/icons/**"

# Check if file is LFS-tracked
git check-attr filter <file-path>

# Normal git commands work as usual
git add .
git commit -m "message"
git push
git pull
```

---

## Important Notes

1. **First Time Setup**: Each developer needs to run `git lfs install` once per machine
2. **After Clone**: Always run `git lfs pull` to download actual files
3. **Normal Workflow**: Regular git commands (`add`, `commit`, `push`, `pull`) work normally
4. **LFS Files**: Stored separately from git repository, downloaded on-demand
5. **Team Coordination**: Make sure all team members have Git LFS installed

---

## Summary (সংক্ষিপ্ত)

**নতুন Clone করার পর:**
1. `git clone <url>`
2. `cd directorist`
3. `git lfs install` (প্রথমবার)
4. `git lfs pull` (LFS ফাইলগুলো ডাউনলোড করতে)

**নিত্য কাজ:**
- সাধারণ git commands ব্যবহার করুন
- নতুন LFS ফাইল থাকলে `git lfs pull` করুন

