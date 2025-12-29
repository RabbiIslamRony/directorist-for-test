You are a senior-level Project Optimization & Git LFS Setup Agent.

I have a WordPress plugin project with a large repository (315MB+) that's causing git clone failures. The repository structure includes:

- Build artifacts (JS/CSS files) mixed with source files in assets/
- Large icon libraries (4500+ SVG files, 16MB+) in assets/icons/
- Vendor JavaScript and CSS files in assets/vendor-js/ and assets/vendor-css/
- Images and other static assets
- Source files in assets/src/ (should stay in git)
- Uses Husky for git hooks (if .husky/ directory exists)

**Your Task:**

1. **Setup Git LFS** for all asset directories:
   - assets/css/**
   - assets/icons/** (16MB+, 4500+ SVG files)
   - assets/images/**
   - assets/js/**
   - assets/vendor-css/**
   - assets/vendor-js/**

2. **Integrate Git LFS with Husky** (if Husky is configured):
   - Check if .husky/_/ directory exists
   - Add Git LFS hooks to .husky/_/pre-push, .husky/_/post-checkout, .husky/_/post-commit, .husky/_/post-merge
   - Ensure compatibility with existing Husky hook system
   - Don't break existing hooks

3. **Update .gitignore** to exclude:
   - Build artifacts (non-minified JS/CSS from assets/js/ and assets/css/)
   - Source maps (*.map files)
   - Keep only production minified files (*.min.js, *.min.css, *.rtl.css, *.rtl.min.css)

4. **Update .gitattributes** with:
   - Git LFS tracking patterns for all 6 asset directories
   - Maintain all existing export-ignore rules
   - Format: `assets/directory/** filter=lfs diff=lfs merge=lfs -text`

5. **Provide migration commands** for existing files:
   - Safe option: Migrate only current branch (HEAD)
   - Full history option: Migrate entire git history (with warning)
   - Commands for each directory separately

**Requirements:**
- Check if Git LFS is installed (git lfs version)
- Initialize Git LFS (git lfs install)
- Track all directories using `git lfs track`
- Verify setup using `git check-attr filter`
- Don't break existing Husky configuration
- Preserve all .gitattributes export-ignore rules
- Provide clear step-by-step instructions
- Verify each step before proceeding

**Expected Results:**
- Repository size reduction: 315MB → ~50-100MB (60-70% reduction)
- All large assets tracked by Git LFS
- Husky integration working properly
- Clear migration steps provided
- Setup verified and working

**Output Format:**
- Step-by-step execution
- Verification after each major step
- Clear next steps for migration
- Troubleshooting tips if needed

Please proceed step by step, verify each configuration, and provide clear instructions for the migration process.
```

---

## Short Version:

```
Setup Git LFS for WordPress plugin repository (315MB → ~50-100MB).

Track with LFS: assets/css/**, assets/icons/**, assets/images/**, assets/js/**, assets/vendor-css/**, assets/vendor-js/**

Integrate with Husky hooks if .husky/ exists. Update .gitattributes and .gitignore. Provide migration commands for existing files. Verify setup.
```

---

## One-Liner:

```
Setup Git LFS: Track assets/css/**, assets/icons/**, assets/images/**, assets/js/**, assets/vendor-css/**, assets/vendor-js/** with LFS. Integrate Husky. Update .gitattributes/.gitignore. Provide migration. Goal: 315MB→50-100MB.
```

