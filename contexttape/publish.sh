#!/bin/bash
# Publish ContextTape to PyPI

set -e

echo "🚀 Publishing ContextTape to PyPI"
echo "=================================="
echo ""

# Navigate to package directory
cd "$(dirname "$0")"

# Check if we're in the right directory
if [ ! -f "pyproject.toml" ]; then
    echo "❌ Error: pyproject.toml not found!"
    echo "   Make sure you're in the contexttape directory"
    exit 1
fi

# Get current version
VERSION=$(grep "^version = " pyproject.toml | cut -d'"' -f2)
echo "📦 Version: $VERSION"
echo ""

# Clean old builds
echo "🧹 Cleaning old builds..."
rm -rf dist/ build/ src/*.egg-info
echo ""

# Run tests
echo "🧪 Running tests..."
python -m pytest tests/ -v --tb=short
if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Tests failed! Fix before publishing."
    exit 1
fi
echo ""

# Build package
echo "🔨 Building package..."
python -m build
if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Build failed!"
    exit 1
fi
echo ""

# Check package
echo "✅ Checking package..."
python -m twine check dist/*
if [ $? -ne 0 ]; then
    echo ""
    echo "❌ Package check failed!"
    exit 1
fi
echo ""

# Show what will be uploaded
echo "📋 Files to upload:"
ls -lh dist/
echo ""

# Confirm upload
read -p "Upload to PyPI? (y/N) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Upload cancelled"
    exit 1
fi

# Upload to PyPI
echo ""
echo "📤 Uploading to PyPI..."
python -m twine upload dist/*

if [ $? -eq 0 ]; then
    echo ""
    echo "=================================="
    echo "✅ Successfully published!"
    echo "=================================="
    echo ""
    echo "Package: contexttape v$VERSION"
    echo "PyPI: https://pypi.org/project/contexttape/"
    echo ""
    echo "Install: pip install contexttape"
    echo ""
else
    echo ""
    echo "❌ Upload failed!"
    exit 1
fi
