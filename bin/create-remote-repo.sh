#!/bin/bash

# Repository name (URL-encoded)
REPO_NAME="Your-Repo-Name"

# Whether the repository should be private (true/false)
PRIVATE=true

# Read credentials from .credentials-file
if [ ! -f "$HOME/.credentials-file" ]; then
    echo "Error: .credentials-file not found in your home directory."
    exit 1
fi

CRED_LINE=$(grep 'github.com' "$HOME/.credentials-file")
if [ -z "$CRED_LINE" ]; then
    echo "Error: GitHub credentials not found in .credentials-file."
    exit 1
fi

USERNAME=$(echo "$CRED_LINE" | sed -n 's/https:\/\/\([^:]*\):.*/\1/p')
TOKEN=$(echo "$CRED_LINE" | sed -n 's/.*:\([^@]*\)@.*/\1/p')

if [ -z "$USERNAME" ] || [ -z "$TOKEN" ]; then
    echo "Error: Unable to extract username or token from .credentials-file."
    exit 1
fi

echo "Using username: $USERNAME"
echo "Token (first 4 characters): ${TOKEN:0:4}..."

# Create the repository on GitHub
echo "Creating repository on GitHub..."
CREATE_REPO_RESPONSE=$(curl -s -H "Authorization: token $TOKEN" \
     -d "{\"name\":\"$REPO_NAME\", \"private\": $PRIVATE}" \
     https://api.github.com/user/repos)

echo "Create repository response:"
echo "$CREATE_REPO_RESPONSE"

# Check if the repository was created successfully
if echo "$CREATE_REPO_RESPONSE" | grep -q '"name": "'; then
    echo "Repository created successfully."
else
    echo "Failed to create repository. Exiting."
    exit 1
fi

# Check if the current directory is a git repository
if [ ! -d .git ]; then
    echo "Initializing local git repository..."
    git init
fi

# Add all files
echo "Adding files to local repository..."
git add -A

# Commit
echo "Committing files..."
git commit -m "Initial remote commit"

# Add the new repository as a remote
echo "Adding remote repository..."
git remote remove origin 2>/dev/null
git remote add origin "https://$USERNAME:$TOKEN@github.com/$USERNAME/$REPO_NAME.git"

# Push to GitHub
echo "Pushing to GitHub..."
git -c credential.helper= push -u origin main

echo "Done! Your local repository is now on GitHub at https://github.com/$USERNAME/$REPO_NAME"
