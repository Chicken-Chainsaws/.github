#!/bin/bash

# Script to sync labels from .github repo to all other repos in the organization
# Usage: cd .github/scripts && ./sync-labels.sh

ORG="Chicken-Chainsaws"
SOURCE_REPO=".github"

echo "🏷️  Label Sync Script for $ORG"
echo "================================="
echo ""

source_full="$ORG/$SOURCE_REPO"

# Verify source repo exists and has labels
echo "📋 Source repository: $source_full"
if ! gh repo view "$source_full" >/dev/null 2>&1; then
    echo "❌ Source repository $source_full not found or not accessible"
    exit 1
fi

# Show labels in source repo
echo ""
echo "Labels in .github repository:"
gh label list --repo "$source_full" | head -5
label_count=$(gh label list --repo "$source_full" | wc -l)
if [ $label_count -gt 5 ]; then
    echo "... and $((label_count - 5)) more (total: $label_count labels)"
else
    echo "(total: $label_count labels)"
fi

# Get list of all repos in the org
echo ""
echo "📋 Fetching all repositories in $ORG..."
repos=$(gh repo list "$ORG" --limit 100 --json name --jq '.[].name')
repo_array=($repos)

if [ ${#repo_array[@]} -eq 0 ]; then
    echo "❌ No repositories found in organization $ORG"
    exit 1
fi

echo "Found ${#repo_array[@]} repositories - syncing labels to all except .github"

echo ""
echo "🚀 Starting label sync..."
echo ""

# Sync to all other repos
success_count=0
error_count=0
skipped_count=0

for repo in "${repo_array[@]}"; do
    if [ "$repo" = "$SOURCE_REPO" ]; then
        echo "⏭️  Skipping $repo (source repository)"
        ((skipped_count++))
        continue
    fi
    
    target_full="$ORG/$repo"
    echo "🔄 Syncing to $repo..."
    
    # First, delete all existing labels
    echo "  🗑️  Deleting existing labels..."
    labels_to_delete=$(gh label list --repo "$target_full" --json name --jq '.[].name' 2>/dev/null || echo "")
    if [ -n "$labels_to_delete" ]; then
        echo "$labels_to_delete" | while read -r label; do
            if [ -n "$label" ]; then
                gh label delete "$label" --repo "$target_full" --yes 2>/dev/null || true
            fi
        done
    fi
    
    # Then clone fresh labels from source
    echo "  📥 Copying labels from .github..."
    if gh label clone "$source_full" --repo "$target_full" 2>/dev/null; then
        echo "  ✅ Success"
        success_count=$((success_count + 1))
    else
        echo "  ❌ Failed"
        error_count=$((error_count + 1))
    fi
    echo ""
done

echo ""
echo "📊 Sync Summary:"
echo "================"
echo "✅ Successful: $success_count"
echo "❌ Failed: $error_count" 
echo "⏭️  Skipped: $skipped_count"
echo ""

if [ $error_count -eq 0 ]; then
    echo "🎉 All repositories synced successfully with .github labels!"
else
    echo "⚠️  Some repositories failed to sync. Check permissions and try again for failed repos."
fi

echo ""
echo "💡 To update labels across all repos:"
echo "   1. Update labels in the .github repository"
echo "   2. Run this script to sync to all other repos"