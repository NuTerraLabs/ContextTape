# 🚀 Quick Reference: GitHub + PyPI Setup

## GitHub Repository Settings

### Basic Info
**Description:**
```
File-based RAG storage: Zero-infrastructure vector database alternative for LLMs. Store embeddings in .is files, no Docker needed.
```

**Website:**
```
https://github.com/NuTerraLabs/RAGLite
```

**Topics (copy-paste all):**
```
rag retrieval-augmented-generation vector-database embeddings llm semantic-search python openai chatgpt langchain llamaindex machine-learning nlp ai file-storage database-free lightweight portable vector-store
```

**Include:**
- ✅ Releases
- ✅ Packages
- ⬜ Deployments (skip)

---

## Publish to PyPI (One-Time Setup)

### 1. Install Tools
```bash
pip install --upgrade build twine
```

### 2. Create PyPI Account
- Go to: https://pypi.org/account/register/
- Create API token: https://pypi.org/manage/account/token/
- Copy token (starts with `pypi-`)

### 3. Save Token
```bash
cat > ~/.pypirc << 'EOF'
[pypi]
username = __token__
password = pypi-YOUR-TOKEN-HERE
EOF
chmod 600 ~/.pypirc
```

### 4. Build & Publish
```bash
cd /home/doom/RAGLite/contexttape

# Clean
rm -rf dist/ build/ src/*.egg-info

# Build
python -m build

# Upload
python -m twine upload dist/*
```

### 5. Verify
```bash
pip install contexttape
python -c "from contexttape import ISStore; print('✅ Works!')"
```

**Done!** Package is live at: https://pypi.org/project/contexttape/

---

## Update Existing Package

1. **Change version** in `pyproject.toml`:
   ```toml
   version = "0.6.0"
   ```

2. **Build and upload:**
   ```bash
   rm -rf dist/
   python -m build
   python -m twine upload dist/*
   ```

---

## Quick Publish Script

Save this as `publish.sh`:

```bash
#!/bin/bash
set -e
cd /home/doom/RAGLite/contexttape
rm -rf dist/ build/ src/*.egg-info
python -m pytest tests/ --tb=short
python -m build
python -m twine check dist/*
python -m twine upload dist/*
echo "✅ Published to PyPI!"
```

Run: `chmod +x publish.sh && ./publish.sh`
