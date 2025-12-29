#!/bin/bash
# Git LFS Files Verification Script

echo "=========================================="
echo "Git LFS Files Verification"
echo "=========================================="
echo ""

echo "1. Checking Git LFS installation..."
if command -v git-lfs &> /dev/null || git lfs version &> /dev/null; then
    git lfs version
    echo "✅ Git LFS is installed"
else
    echo "❌ Git LFS is NOT installed"
    echo "   Install: https://git-lfs.github.com/"
    exit 1
fi

echo ""
echo "2. Checking remote repository LFS files..."
if git lfs ls-remote origin &> /dev/null; then
    LFS_COUNT=$(git lfs ls-remote origin 2>/dev/null | wc -l)
    echo "   Found $LFS_COUNT LFS files on remote"
    git lfs ls-remote origin | head -5
else
    echo "   ⚠️  Could not check remote (might need to push first)"
fi

echo ""
echo "3. Checking local LFS-tracked files..."
LOCAL_COUNT=$(git lfs ls-files 2>/dev/null | wc -l)
echo "   Found $LOCAL_COUNT LFS files locally"
git lfs ls-files | head -5

echo ""
echo "4. Verifying .gitattributes configuration..."
if grep -q "assets/css/\*\*" .gitattributes; then
    echo "   ✅ assets/css/** is tracked"
else
    echo "   ❌ assets/css/** is NOT tracked"
fi

if grep -q "assets/icons/\*\*" .gitattributes; then
    echo "   ✅ assets/icons/** is tracked"
else
    echo "   ⚠️  assets/icons/** is NOT tracked (might be intentional)"
fi

if grep -q "assets/js/\*\*" .gitattributes; then
    echo "   ✅ assets/js/** is tracked"
else
    echo "   ❌ assets/js/** is NOT tracked"
fi

echo ""
echo "5. Testing specific file attributes..."
echo "   assets/css/admin-main.min.css:"
git check-attr filter assets/css/admin-main.min.css 2>/dev/null || echo "      (file not found)"

echo ""
echo "6. Repository status..."
git status --short | head -5

echo ""
echo "=========================================="
echo "Verification Summary"
echo "=========================================="
echo ""
echo "To verify files are on server:"
echo "  1. Push your changes: git push"
echo "  2. Check remote: git lfs ls-remote origin"
echo "  3. Test clone: git clone <url> test-clone && cd test-clone && git lfs pull"
echo ""
echo "If files are deleted and pushed, they will NOT be available after pull."
echo "This is normal behavior - use git history to recover if needed."
echo ""

