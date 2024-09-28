[![Deploy Site](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/actions/workflows/siteDeploy.yaml/badge.svg)](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/actions/workflows/siteDeploy.yaml)
[![Update Site](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/actions/workflows/siteUpdate.yaml/badge.svg)](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/actions/workflows/siteUpdate.yaml)
[![Destroy Site](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/actions/workflows/siteDestroy.yaml/badge.svg)](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/actions/workflows/siteDestroy.yaml)

# 🌐 EASY!!! - `AWS S3-Hosted Website CI/CD` - EASY!!!

This project provides a super easy solution for hosting a static website on Amazon S3, using a DevOps workflow, IaC & GitHub Actions for automated deployment and updates. **All you need is a domain and a hosted zone!**

**Note:** *All of the code was created with the assistance of **Amazon Q***

## 🔄 Workflows

### 🆕 Deploy Site
Manually triggered or comment-triggered workflow to deploy the website.

- **How to Trigger**: Trigger this workflow through the GitHub Actions tab or by adding a comment like `deploy-site` on a commit and push it to origin.

### 🔄 Update Site
Automatically updates the **S3 bucket** and invalidates the **CloudFront distribution** when changes to the `website-prod` directory are pushed to the `main` branch.

- **Note**: Ensure environment variables such as `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_REGION` are set in your GitHub repository secrets for proper CI/CD functionality. See [GitHub Secrets Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets) for details.

### 🗑️ Destroy Site
Manually or comment-triggered workflow to tear down the website infrastructure.

- **How to Trigger**: Trigger this workflow through the GitHub Actions tab or by adding a comment like `destroy-site` on a commit and push it to origin.

---

## 🚀 Features
- Automated deployment to **Amazon S3** using **CloudFormation**.
- **CloudFront** distribution for fast content delivery.
- **Origin Access Control (OAC)** for secure delivery.
- **SSL/TLS Certificate** for secure connections.
- **GitHub Actions** for a fully automated CI/CD pipeline.
- Easy local development workflow with a customizable structure.

---

## 📋 Prerequisites
- **Local Dev Environment** (or Gitpod)
- **GitHub Account, Secrets & Access Token** (For Automation)
- **AWS Account, User & Permissions** (For Hosting and Deployment)
- **Domain & Hosted Zone** (To Route Your Traffic)

---

## 🔧 Configuration Steps
1. **Set-up AWS User**
   .
2. **Set GitHub Repo Secrets**

1. **Prepare Environment**  
   Set up your local development environment or use a cloud environment like Gitpod. Learn how [HERE!](https://github.com/Warner-Bell/Easy-Dev-Env-Setup/blob/main/README.md)

2. **Clone Repo**  
   Clone the repository:

    ```bash
    git clone https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD.git
    ```

    Navigate to the project directory:

    ```bash
    cd AWS-S3Hosted-Website-CI_CD
    ```

3. **Edit Config File**  
   Update the configuration file (`config.sh`) with the correct values such as **S3 Bucket Names**, **Domain Name**, **Hosted Zone ID**, etc.  
   See [CONFIG_SETUP.md](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/blob/f070c8c586f654f576928a14680486e3005c005b/CONFIG_SETUP.md) for detailed instructions.

4. **Edit Credentials File**  
   Edit the `.credential-file` to include your GitHub token and username, then rename it to `.credentials-file.env`.

5. **Edit `website-prod` Directory**  
   Use the provided **Demo Site** or replace the demo files in the `website-prod` directory with your own HTML, CSS, and JS files. Ensure your file structure aligns with the project setup for smooth deployment.

6. **Test Locally**  
   Test your changes locally. Use a tool like `http-server` to serve your static files for local testing:

    ```bash
    npm install -g http-server
    http-server ./website-prod
    ```

7. **Commit Changes**  
   Commit all the changes you made to the repository:

    ```bash
    git add .
    git commit -m "Your New S3 Website"
    ```

8. **Create Remote Repo**  
   Create a Remote Copy of your customized repository on GitHub by editing the `REPO_NAME=` variable in the [create-remote-repo.sh](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/blob/966af9c5136f472f4341ea60cd545249307d1344/create-remote-repo.sh) file, then run the script.

9. **Push Changes and Deploy Site**  
   Commit your changes:

    ```
    git add .
    git commit -m "deploy-site"
    ```
   Push your changes to trigger the deploy workflow:

    ```bash
    git push origin main
    ```

---
![image](https://github.com/user-attachments/assets/495294b3-bc81-46dd-91c3-70091b160d1e)
---

## 📚 Additional Resources

- [Amazon Q Documentation](https://docs.aws.amazon.com/amazonq/)
- [CloudFormation Documentation](https://docs.aws.amazon.com/cloudformation/)
- [Amazon S3 Documentation](https://docs.aws.amazon.com/s3/)
- [CloudFront Documentation](https://docs.aws.amazon.com/cloudfront/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [AWS IAM Role Permissions Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html)
- [Route 53 Hosted Zone Documentation](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/Welcome.html)

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Here's how you can contribute:

1. Fork the project:

    ```bash
    git checkout -b feature/AmazingFeature
    ```

2. Commit your changes:

    ```bash
    git commit -m 'Add some AmazingFeature'
    ```

3. Push to the branch:

    ```bash
    git push origin feature/AmazingFeature
    ```

4. Open a pull request:

Feel free to check the [issues page](TBD) for any open issues or feature requests.

---

## 📝 License

This project is licensed under the [MIT License](TBD).

---

## 📬 Contact

Warner Bell - [Tap In!](https://dot.cards/warnerbell) - yo@warnerbell.com

Project Link: [S3-Website](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD)
