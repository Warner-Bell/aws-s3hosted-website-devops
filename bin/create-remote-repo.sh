#!/bin/bash

# Repository name (URL-encoded)
REPO_NAME="TEST-demo-site"

# Whether the repository should be private (true/false)
PRIVATE=true

# Define the path to the project folder on the Desktop
PROJECT_DIR="/mnt/c/Users/Warner Bell/Desktop/AWS-S3Hosted-Website-CI_CD" # for WSL

# Check if credentials-file.env exists in the project folder
if [ ! -f "$PROJECT_DIR/credentials-file.env" ]; then
    echo "Error: credentials-file.env not found in the project directory."
    exit 1
fi

# Load the credentials from credentials-file.env
source "$PROJECT_DIR/credentials-file.env"

# Extract the username and token from the GITHUB_TOKEN URL
USERNAME=$(echo "$GITHUB_TOKEN" | sed -n 's|https://\([^:]*\):.*|\1|p')
TOKEN=$(echo "$GITHUB_TOKEN" | sed -n 's|https://[^:]*:\([^@]*\)@.*|\1|p')

if [ -z "$USERNAME" ] || [ -z "$TOKEN" ]; then
    echo "Error: Unable to extract username or token from GITHUB_TOKEN."
    exit 1
fi

echo "Using username: $USERNAME"
echo "Token (first 4 characters): ${TOKEN:0:4}..."

# Create the repository on GitHub using the extracted token
echo "Creating repository on GitHub..."
CREATE_REPO_RESPONSE=$(curl -s -H "Authorization: token $TOKEN" \
     -d "{\"name\":\"$REPO_NAME\", \"private\": $PRIVATE}" \
     https://api.github.com/user/repos)

# Check if the repository was created successfully
if echo "$CREATE_REPO_RESPONSE" | grep -q '"name": "'; then
    echo "Repository created successfully."
else
    echo "Failed to create repository. Response from GitHub API:"
    echo "$CREATE_REPO_RESPONSE"
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

# Add the new repository as a remote (without embedding the token in the URL)
if git remote | grep -q "origin"; then
    git remote remove origin
fi
echo "Adding remote repository..."
git remote add origin "https://github.com/$USERNAME/$REPO_NAME.git"

# Set up GIT_ASKPASS to pass the token securely for the push
GIT_ASKPASS=$(mktemp)
chmod +x $GIT_ASKPASS
cat <<EOF >$GIT_ASKPASS
#!/bin/sh
echo $TOKEN
EOF

# Push to GitHub, dynamically detect branch name
BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Pushing to GitHub..."
GIT_ASKPASS=$GIT_ASKPASS git push -u origin "$BRANCH"

# Clean up the temporary GIT_ASKPASS script
rm -f $GIT_ASKPASS

echo "Done! Your local repository is now on GitHub at https://github.com/$USERNAME/$REPO_NAME"
