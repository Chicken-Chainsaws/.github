# Organization Management Scripts

This directory contains automation scripts for managing the Chicken-Chainsaws organization.

## Scripts

### `sync-labels.sh`

Synchronizes labels from this `.github` repository to all other repositories in the organization.

**Purpose:** Maintain consistent labeling across all organization repositories

**Usage:**
```bash
cd scripts
./sync-labels.sh
```

**What it does:**
1. Uses the `.github` repository as the source of truth for labels
2. Fetches all repositories in the organization
3. For each repository (except `.github`):
   - Deletes all existing labels
   - Copies all labels from `.github` repository
4. Reports success/failure summary

**When to run:**
- After adding, editing, or removing labels in the `.github` repository
- When onboarding new repositories
- Periodically to ensure consistency

**Requirements:**
- GitHub CLI (`gh`) installed and authenticated
- Write access to all organization repositories
- Run from within the `.github` repository

## Adding New Scripts

When adding new organization management scripts:

1. **Make them executable:** `chmod +x script-name.sh`
2. **Add clear documentation** in this README
3. **Use consistent naming:** `kebab-case.sh`
4. **Include usage examples** and error handling
5. **Test thoroughly** before committing

## Security Note

These scripts have access to modify organization repositories. Always:
- Review scripts before running
- Test on a small subset first when possible
- Verify permissions and access levels
- Keep scripts in version control