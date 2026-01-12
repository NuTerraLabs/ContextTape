# GitHub Actions Workflows Setup

## Files Created

✅ `.github/workflows/publish-to-pypi.yml` - Auto-publish to PyPI on release
✅ `.github/workflows/test.yml` - Run tests on every push

---

## Setup Instructions

### 1. Configure PyPI Trusted Publishing (Recommended)

This is the **secure way** - no API tokens needed!

#### On PyPI:
1. Go to https://pypi.org/manage/account/publishing/
2. Click **"Add a new pending publisher"**
3. Fill in:
   - **PyPI Project Name:** `contexttape`
   - **Owner:** `NuTerraLabs` (your GitHub username/org)
   - **Repository name:** `RAGLite`
   - **Workflow name:** `publish-to-pypi.yml`
   - **Environment name:** (leave blank)
4. Click **"Add"**

#### On GitHub:
Nothing needed! The workflow uses `id-token: write` for trusted publishing.

---

### 2. How to Publish a Release

#### Option A: GitHub Releases (Automated)
1. Go to: https://github.com/NuTerraLabs/RAGLite/releases/new
2. **Tag version:** `v0.5.0` (must start with `v`)
3. **Release title:** `v0.5.0 - Initial Release`
4. **Description:** Changelog notes
5. Click **"Publish release"**

→ GitHub Actions will automatically:
- ✅ Run all tests
- ✅ Build the package
- ✅ Publish to PyPI

#### Option B: Manual Trigger
1. Go to: https://github.com/NuTerraLabs/RAGLite/actions
2. Select **"Publish to PyPI"** workflow
3. Click **"Run workflow"**
4. Confirm

---

### 3. Alternative: Use API Token

If you don't want to use trusted publishing:

#### On PyPI:
1. Create token: https://pypi.org/manage/account/token/
2. Copy token (starts with `pypi-`)

#### On GitHub:
1. Go to: https://github.com/NuTerraLabs/RAGLite/settings/secrets/actions
2. Click **"New repository secret"**
3. Name: `PYPI_API_TOKEN`
4. Value: Paste your token
5. Click **"Add secret"**

Then update `.github/workflows/publish-to-pypi.yml`:
```yaml
    - name: Publish to PyPI
      env:
        TWINE_USERNAME: __token__
        TWINE_PASSWORD: ${{ secrets.PYPI_API_TOKEN }}
      run: |
        cd contexttape
        python -m twine upload dist/*
```

---

## Workflow Details

### `publish-to-pypi.yml`
**Triggers:**
- When you create a GitHub release
- Manual trigger from Actions tab

**Steps:**
1. Runs all tests (must pass)
2. Builds package
3. Publishes to PyPI

**Requirements:**
- PyPI trusted publishing configured OR
- PYPI_API_TOKEN secret set

### `test.yml`
**Triggers:**
- Every push to `main` or `develop`
- Every pull request to `main`

**Steps:**
1. Tests on Python 3.9, 3.10, 3.11, 3.12
2. Runs with coverage reporting
3. Tests CLI commands

---

## Usage Workflow

### Making a Release

1. **Update version** in `pyproject.toml`:
   ```toml
   version = "0.5.0"
   ```

2. **Update CHANGELOG.md**:
   ```markdown
   ## [0.5.0] - 2026-01-12
   ### Added
   - Initial release
   ```

3. **Commit and push**:
   ```bash
   git add pyproject.toml CHANGELOG.md
   git commit -m "Prepare v0.5.0 release"
   git push origin main
   ```

4. **Create GitHub release**:
   - Go to: https://github.com/NuTerraLabs/RAGLite/releases/new
   - Tag: `v0.5.0`
   - Title: `v0.5.0 - Initial Release`
   - Description: Copy from CHANGELOG.md
   - Click **"Publish release"**

5. **Wait for automation**:
   - Watch: https://github.com/NuTerraLabs/RAGLite/actions
   - Should see green checkmarks ✅
   - Package appears on PyPI within 2-3 minutes

6. **Verify**:
   ```bash
   pip install --upgrade contexttape
   python -c "from contexttape import ISStore; print('✅')"
   ```

---

## Monitoring

### Check Workflow Status
https://github.com/NuTerraLabs/RAGLite/actions

### Check PyPI Package
https://pypi.org/project/contexttape/

### View Test Coverage
Tests run on every push and show coverage in the logs

---

## Troubleshooting

### "Trusted publishing not configured"
**Solution:** Follow step 1 above to configure on PyPI

### "Tests failed"
**Solution:** Fix failing tests before creating release
```bash
cd contexttape
python -m pytest tests/ -v
```

### "Authentication failed"
**Solution:** 
- Check PyPI trusted publishing is configured correctly
- OR check PYPI_API_TOKEN secret is set

### "Version already exists"
**Solution:** Bump version in `pyproject.toml` to next number

---

## Benefits of This Setup

✅ **Automated testing** on every push
✅ **Multi-Python version testing** (3.9-3.12)
✅ **Secure publishing** (no tokens in code)
✅ **Version control** via Git tags
✅ **Release notes** via GitHub releases
✅ **Audit trail** via GitHub Actions logs

---

## Next Steps

1. **Commit workflows**:
   ```bash
   git add .github/workflows/
   git commit -m "Add GitHub Actions workflows"
   git push origin main
   ```

2. **Configure PyPI trusted publishing** (see step 1 above)

3. **Create first release** (see "Making a Release" above)

🚀 **Ready for automated publishing!**
