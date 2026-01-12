# 📋 GitHub & PyPI Setup Checklist

## ✅ GitHub Repository Details

Copy these values into your GitHub repository settings:

### 1. Description (Required)
```
File-based RAG storage: Zero-infrastructure vector database alternative for LLMs. Store embeddings in .is files, no Docker needed.
```

### 2. Website (Optional)
```
https://github.com/NuTerraLabs/RAGLite
```

### 3. Topics (Important for Discoverability)
**Copy all these space-separated tags:**
```
rag retrieval-augmented-generation vector-database embeddings llm semantic-search python openai chatgpt langchain llamaindex machine-learning nlp ai file-storage database-free lightweight portable vector-store
```

### 4. Features to Include
- ✅ **Releases** (check this)
- ✅ **Packages** (check this - will show PyPI badge)
- ⬜ **Deployments** (uncheck - not needed)

---

## 🚀 Publishing to PyPI

### Option A: Using the Script (Easiest)

```bash
cd /home/doom/RAGLite/contexttape

# First time: install tools
pip install --upgrade build twine

# Publish
./publish.sh
```

The script will:
1. ✅ Clean old builds
2. ✅ Run all tests
3. ✅ Build the package
4. ✅ Check the package
5. ✅ Upload to PyPI

### Option B: Manual Steps

```bash
cd /home/doom/RAGLite/contexttape

# Install tools (first time only)
pip install --upgrade build twine

# Clean, build, upload
rm -rf dist/ build/ src/*.egg-info
python -m build
python -m twine upload dist/*
```

---

## 🔑 PyPI Authentication (First Time Setup)

### 1. Create PyPI Account
Go to: https://pypi.org/account/register/

### 2. Get API Token
1. Go to: https://pypi.org/manage/account/token/
2. Click **"Add API token"**
3. Name: `contexttape-upload`
4. Scope: **Entire account** (or specific project later)
5. **Copy the token** (starts with `pypi-`)

### 3. Save Token Locally
```bash
# Create .pypirc file
cat > ~/.pypirc << 'EOF'
[pypi]
username = __token__
password = pypi-AgEIcHlwaS5vcmcC...YOUR-TOKEN-HERE
EOF

# Secure the file
chmod 600 ~/.pypirc
```

Now `twine upload` will use this token automatically!

---

## ✅ Post-Publication

After publishing, verify:

### 1. Check PyPI
Visit: https://pypi.org/project/contexttape/

### 2. Test Install
```bash
# In a fresh environment
pip install contexttape
python -c "from contexttape import ISStore; print('✅ Works!')"
```

### 3. Update README Badges (Optional)
Add to top of README:
```markdown
[![PyPI version](https://badge.fury.io/py/contexttape.svg)](https://pypi.org/project/contexttape/)
[![Downloads](https://static.pepy.tech/badge/contexttape)](https://pepy.tech/project/contexttape)
```

---

## 🔄 Updating the Package

When you make changes and want to release a new version:

### 1. Update Version
Edit `pyproject.toml`:
```toml
version = "0.6.0"  # Bump from 0.5.0
```

### 2. Update Changelog
Edit `CHANGELOG.md`:
```markdown
## [0.6.0] - 2026-01-15
### Added
- New feature X
### Fixed  
- Bug Y
```

### 3. Commit & Tag
```bash
git add pyproject.toml CHANGELOG.md
git commit -m "Release v0.6.0"
git tag v0.6.0
git push origin main --tags
```

### 4. Publish
```bash
./publish.sh
```

---

## 📊 What People Will See

### On PyPI
```
contexttape 0.5.0
File-based RAG: Database-free vector storage for Retrieval-Augmented Generation

pip install contexttape

Homepage | Documentation | Repository | Issues
```

### On GitHub
```
📦 NuTerraLabs/RAGLite

File-based RAG storage: Zero-infrastructure vector database 
alternative for LLMs. Store embeddings in .is files, no Docker needed.

⭐ Star this repo

Topics: rag, vector-database, embeddings, llm, python, openai...

✅ 55 passing tests
📦 Available on PyPI
```

### When Someone Searches
- **"python rag"** → ✅ Will find it
- **"vector database alternative"** → ✅ Will find it  
- **"embeddings storage"** → ✅ Will find it
- **"file-based rag"** → ✅ Will find it

---

## 🛠️ Troubleshooting

### "HTTPError: 400 File already exists"
**Problem:** Version 0.5.0 already on PyPI  
**Solution:** Bump version to 0.5.1 or 0.6.0 in `pyproject.toml`

### "Invalid or non-existent authentication"
**Problem:** Wrong token or token not saved  
**Solution:** Check `~/.pypirc` has correct token

### "Tests failed"
**Problem:** Some tests failing  
**Solution:** Run `python -m pytest tests/ -v` and fix failures

### "Command 'twine' not found"
**Problem:** Build tools not installed  
**Solution:** `pip install --upgrade build twine`

---

## 📞 Need Help?

- **Documentation**: See `PUBLISH_TO_PYPI.md` for detailed guide
- **PyPI Help**: https://pypi.org/help/
- **Twine Docs**: https://twine.readthedocs.io/

---

## ✅ Final Checklist

Before publishing:
- [ ] All tests passing (`python -m pytest tests/`)
- [ ] Version bumped in `pyproject.toml`
- [ ] CHANGELOG.md updated
- [ ] Git committed and pushed
- [ ] PyPI token saved in `~/.pypirc`
- [ ] README looks good (will be shown on PyPI)

Then run: `./publish.sh`

🎉 **You're ready to publish!**
