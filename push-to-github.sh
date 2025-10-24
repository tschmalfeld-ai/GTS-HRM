#!/bin/bash

echo "🚀 Heart Rate Monitor - Push to GitHub"
echo "======================================"
echo ""

# Check if git is initialized
if [ ! -d .git ]; then
    echo "Initializing git repository..."
    git init
    git branch -M main
fi

# Add all files
echo "Adding all files..."
git add .

# Prompt for commit message
echo ""
read -p "Enter commit message (or press Enter for default): " commit_msg
if [ -z "$commit_msg" ]; then
    commit_msg="Update Heart Rate Monitor app"
fi

# Commit
echo "Committing changes..."
git commit -m "$commit_msg"

# Check if remote exists
if ! git remote | grep -q origin; then
    echo ""
    echo "⚠️  No GitHub remote configured!"
    echo ""
    echo "Please create a repository on GitHub, then run:"
    echo "git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git"
    echo "git push -u origin main"
else
    # Push
    echo "Pushing to GitHub..."
    git push -u origin main
    echo ""
    echo "✅ Done! Check your GitHub repository's Actions tab to see the build progress."
    echo "Your APK will be ready in about 5-10 minutes!"
fi
