# Publishing ContextTape to PyPI

## GitHub Repository Details

### Description (Short - appears at top)
```
File-based RAG storage: Zero-infrastructure vector database alternative for LLMs. Store embeddings in .is files, no Docker needed.
```

### Website
```
https://github.com/NuTerraLabs/RAGLite
```

### Topics (GitHub tags - space separated)
```
rag retrieval-augmented-generation vector-database embeddings llm semantic-search python openai chatgpt langchain llamaindex machine-learning nlp ai file-storage database-free lightweight portable
```

### Include in home page
- ✅ Releases
- ✅ Packages (once published to PyPI)
- ⬜ Deployments (not needed)

---

## Publishing to PyPI

### Prerequisites

1. **Create PyPI account**: https://pypi.org/account/register/
2. **Install build tools**:
   ```bash
   pip install --upgrade build twine
   ```

### Step-by-Step Publishing

#### 1. Verify Version
```bash
cd /home/doom/RAGLite/contexttape
cat pyproject.toml | grep version
# Should show: version = "0.5.0"
```

#### 2. Clean Previous Builds
```bash
rm -rf dist/ build/ src/*.egg-info
```

#### 3. Build Package
```bash
python -m build
```

This creates:
- `dist/contexttape-0.5.0.tar.gz` (source distribution)
- `dist/contexttape-0.5.0-py3-none-any.whl` (wheel)

#### 4. Test Upload to TestPyPI (Optional but Recommended)
```bash
# Register at https://test.pypi.org/account/register/
python -m twine upload --repository testpypi dist/*
```

Test install:
```bash
pip install --index-url https://test.pypi.org/simple/ contexttape
```

#### 5. Upload to PyPI (Production)
```bash
python -m twine upload dist/*
```

You'll be prompted for:
- **Username**: Your PyPI username
- **Password**: Your PyPI password (or API token)

#### 6. Verify Installation
```bash
pip install contexttape
python -c "from contexttape import ISStore; print('✅ Published!')"
```

---

## Using PyPI API Token (More Secure)

### 1. Create API Token
1. Go to https://pypi.org/manage/account/token/
2. Click "Add API token"
3. Name it: `contexttape-upload`
4. Copy the token (starts with `pypi-`)

### 2. Create ~/.pypirc
```bash
cat > ~/.pypirc << 'EOF'
[distutils]
index-servers =
    pypi
    testpypi

[pypi]
username = __token__
password = pypi-YOUR-TOKEN-HERE

[testpypi]
username = __token__
password = pypi-YOUR-TESTPYPI-TOKEN-HERE
EOF

chmod 600 ~/.pypirc
```

### 3. Upload with Token
```bash
python -m twine upload dist/*
# No prompt - uses token from ~/.pypirc
```

---

## Complete Publishing Workflow

```bash
#!/bin/bash
# publish_to_pypi.sh

set -e

echo "🚀 Publishing ContextTape to PyPI"

# 1. Clean
echo "Cleaning old builds..."
rm -rf dist/ build/ src/*.egg-info

# 2. Run tests
echo "Running tests..."
python -m pytest tests/ -v
if [ $? -ne 0 ]; then
    echo "❌ Tests failed! Fix before publishing."
    exit 1
fi

# 3. Build
echo "Building package..."
python -m build

# 4. Check package
echo "Checking package..."
python -m twine check dist/*

# 5. Upload
echo "Uploading to PyPI..."
python -m twine upload dist/*

echo "✅ Published! Install with: pip install contexttape"
```

Save as `publish_to_pypi.sh`, then:
```bash
chmod +x publish_to_pypi.sh
./publish_to_pypi.sh
```

---

## Updating PyPI Page

After publishing, update these on PyPI:

### 1. Project Description
PyPI automatically uses your `README.md`

### 2. Project URLs (in pyproject.toml)
```toml
[project.urls]
Homepage = "https://github.com/NuTerraLabs/RAGLite"
Documentation = "https://github.com/NuTerraLabs/RAGLite/tree/main/contexttape"
Repository = "https://github.com/NuTerraLabs/RAGLite"
Issues = "https://github.com/NuTerraLabs/RAGLite/issues"
Changelog = "https://github.com/NuTerraLabs/RAGLite/blob/main/contexttape/CHANGELOG.md"
```

### 3. Classifiers (already in pyproject.toml)
Already set:
- Development Status :: 4 - Beta
- License :: OSI Approved :: MIT License
- Programming Language :: Python :: 3.9+
- Topic :: Scientific/Engineering :: Artificial Intelligence

---

## Version Updates

### For Future Releases

1. Update version in `pyproject.toml`:
   ```toml
   version = "0.6.0"  # or "1.0.0"
   ```

2. Update `CHANGELOG.md`:
   ```markdown
   ## [0.6.0] - 2026-01-15
   ### Added
   - New feature X
   ### Fixed
   - Bug Y
   ```

3. Commit and tag:
   ```bash
   git add pyproject.toml CHANGELOG.md
   git commit -m "Release v0.6.0"
   git tag v0.6.0
   git push origin main --tags
   ```

4. Publish:
   ```bash
   ./publish_to_pypi.sh
   ```

---

## Post-Publication Checklist

- [ ] Verify on PyPI: https://pypi.org/project/contexttape/
- [ ] Test fresh install: `pip install contexttape`
- [ ] Update GitHub release notes
- [ ] Update shields/badges in README if needed
- [ ] Announce on social media/forums
- [ ] Update documentation links

---

## Troubleshooting

### "File already exists"
```
HTTPError: 400 Bad Request
The file 'contexttape-0.5.0.tar.gz' already exists on PyPI.
```
**Solution**: Bump version in `pyproject.toml` to 0.5.1 or 0.6.0

### "Invalid authentication credentials"
**Solution**: Check ~/.pypirc or use `--username` and `--password` flags

### "Package description invalid"
**Solution**: Ensure README.md is valid Markdown, no syntax errors

### "Missing required metadata"
**Solution**: Ensure pyproject.toml has all required fields:
- name
- version
- description
- readme
- requires-python
- license
- authors

---

## Quick Commands Reference

```bash
# Build
python -m build

# Check
python -m twine check dist/*

# Upload to TestPyPI
python -m twine upload --repository testpypi dist/*

# Upload to PyPI
python -m twine upload dist/*

# Install locally for testing
pip install -e .

# Uninstall
pip uninstall contexttape
```
