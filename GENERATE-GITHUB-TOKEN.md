# 🔐 How to Generate a GitHub Personal Access Token (PAT)

Follow these steps to create a GitHub Personal Access Token (PAT) to use for authentication with Git or other tools:

## 1. 🔑 **Log in to GitHub:**
   - Go to [GitHub](https://github.com) and log in to your account.

## 2. ⚙️ **Access Developer Settings:**
   - In the upper-right corner of any GitHub page, click your profile picture.
   - Select **Settings** from the dropdown.
   - Scroll down and, on the left sidebar, click **Developer settings**.

## 3. 🛠 **Generate a Personal Access Token:**
   - In **Developer settings**, select **Personal access tokens** from the sidebar.
   - Click on **Tokens (classic)** and then click **Generate new token**.
   - Give the token a descriptive name, such as _"Git CLI Token"_, so you can remember why you created it.

## 4. 🔐 **Select Scopes and Permissions:**
   - Choose the scopes or permissions to grant this token. For full access to repositories (push, pull, etc.), select the `repo` scope.
   - You may also want to choose `workflow` for GitHub Actions or `admin:repo_hook` for repository webhooks.
   - If you only need specific permissions, select the minimum necessary scopes for better security.

## 5. ⚡ **Generate the Token:**
   - After selecting your desired scopes, click **Generate token** at the bottom of the page.

## 6. 📋 **Copy the Token:**
   - **Important**: Once the token is generated, copy it immediately. You **won't** be able to view the token again after you leave the page.

## 7. 🛡 **Store the Token Safely:**
   - Save the token in a secure location, like a password manager.
   - Use this token instead of your password when performing operations like pushing or pulling from a GitHub repository.

---

## 🧑‍💻 **Using the Token with Git:**
When prompted for a username and password during Git operations, use:
- **Username**: Your GitHub username.
- **Password**: Paste your newly generated PAT.

Example during `git push` or `git pull`:

```shell
Username: your-github-username
Password: your-access-token
