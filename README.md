# Chicken-Chainsaws Organization Configuration

This repository contains organization-wide GitHub configurations, issue templates, and management scripts for all repositories in the Chicken-Chainsaws organization.

## 📁 Repository Structure

```
.github/
├── .github/ISSUE_TEMPLATE/     # Issue form templates (YAML)
├── profile/                    # Organization profile README
├── scripts/                    # Management and automation scripts
└── README.md                   # This file
```

## 🏷️ Label Management

This organization uses a standardized set of 23 labels across all repositories for consistent issue and PR management.

### Label Categories

#### Platform Labels
- `android` - Android app–specific issues
- `ios` - iPhone/iPad app–specific issues
- `frontend` - UI work not specific to Android/iOS
- `backend` - server-side logic, business rules, cloud functions
- `database` - schema, queries, migrations, optimization
- `api` - REST/GraphQL endpoints, backend APIs

#### Feature Area Labels
- `auth` - login, signup, identity, permissions
- `camera` - photo capture, validation, AR, device integrations
- `location` - GPS, geofencing, maps
- `notifications` - push notifications, background jobs
- `social` - Facebook, Instagram, or other social integration
- `analytics` - event tracking, reporting, usage metrics
- `ui-ux` - visual design, layout, navigation

#### Process Labels
- `needs-design` - requires UI/UX design input before implementation
- `needs-info` - missing details/specs to move forward
- `research` - investigate an approach or technology
- `prototype` - build a small version to test feasibility
- `testing` - automated/unit/integration tests
- `ci` - continuous integration / continuous delivery
- `docs` - documentation, README, API specs, guides
- `cost` - anything cost-related

#### Status Labels
- `duplicate` - duplicate of another issue
- `wontfix` - won't be fixed (decision made to skip)

### Syncing Labels Across Repositories

To maintain consistency, labels are managed centrally in this `.github` repository and synced to all other repositories using our label sync script.

**To sync labels to all repositories:**

```bash
cd .github/scripts
./sync-labels.sh
```

**The sync process:**
1. Uses this `.github` repository as the source of truth for labels
2. Completely replaces labels in all other organization repositories
3. Ensures perfect consistency across all repos

**When to run the sync:**
- After adding, editing, or removing labels in this repository
- When onboarding new repositories to the organization
- Periodically to ensure consistency

## 📋 Issue Templates

Issue templates are automatically available across all repositories in the organization when creating new issues.

### Available Templates
- **Bug Report** - Report bugs and defects using a structured form
- **Feature Request** - Request new features with detailed specifications
- **Enhancement** - Propose improvements to existing features
- **Requirement** - Document detailed requirements and specifications
- **Chore** - Maintenance tasks, cleanup, and technical debt

### Template Customization
Individual repositories can override these organization-wide templates by creating their own `.github/ISSUE_TEMPLATE/` directory.

## 🛠️ Scripts

### `scripts/sync-labels.sh`
Synchronizes labels from this repository to all other repositories in the organization.

**Usage:**
```bash
cd .github/scripts
./sync-labels.sh
```

**Features:**
- Automatic detection of all organization repositories
- Complete label replacement (not merge) for consistency
- Progress reporting and error handling
- No user prompts - fully automated

## 🔧 Management Workflow

### Adding New Labels
1. Add labels to this `.github` repository (via web interface or API)
2. Run the label sync script to apply to all repositories
3. Document the new label in this README

### Updating Issue Templates
1. Edit templates in `.github/ISSUE_TEMPLATE/` directory
2. Changes are automatically available organization-wide
3. Test with a new issue in any repository

### Onboarding New Repositories
1. Create the new repository
2. Run the label sync script to apply standard labels
3. Issue templates are automatically inherited

## 📊 Repository Status

All Chicken-Chainsaws repositories use:
- ✅ Standardized labels (23 total)
- ✅ Organization-wide issue templates
- ✅ Consistent issue management workflow

---

For questions or suggestions about organization configuration, please create an issue in this repository.