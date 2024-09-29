[![Deploy Site](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/actions/workflows/siteDeploy.yaml/badge.svg)](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/actions/workflows/siteDeploy.yaml)
[![Update Site](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/actions/workflows/siteUpdate.yaml/badge.svg)](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/actions/workflows/siteUpdate.yaml)
[![Destroy Site](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/actions/workflows/siteDestroy.yaml/badge.svg)](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/actions/workflows/siteDestroy.yaml)

# 🌐 EASY!!! - `AWS S3-Hosted Website CI/CD` - EASY!!!

Want to learn **DevOps, IAC, CI\CD, AWS, and GitHub Actions** all while building a cool inexpensive website for your brand or business?

This project provides a super easy solution for hosting a static website on Amazon S3, using a DevOps workflow, IaC & GitHub Actions for automated deployment and updates. **All you need is a Domain!**

**Guess What!:** *All of this code was refactored and enhanced with the assistance of **Amazon Q** 

## 🔄 Workflows

### 🆕 Deploy Site
Comment-triggered workflow to deploy the website.

- **How to Trigger**: Trigger this workflow by adding the comment `deploy-site` on a commit and push it to your GitHub origin.

### 🔄 Update Site
Automatically updates the **S3 bucket** and invalidates the **CloudFront distribution** when changes to the `website-prod` directory are pushed to the GitHub origin's `main` branch.

### 🗑️ Destroy Site
Comment-triggered workflow to tear down the website infrastructure.

- **How to Trigger**: Trigger this workflow by adding adding the comment `destroy-site` on a commit and push it to origin.

- **Note**: Ensure environment variables such as `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_REGION` are set in your GitHub repository secrets for proper CI/CD functionality. See [GitHub Secrets Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets) for more info.

---

## 🚀 Features
- Automated deployment to **Amazon S3** using **IAC & CloudFormation**.
- **CloudFront** distribution for fast content delivery.
- **Origin Access Control (OAC)** for secure delivery.
- **SSL/TLS Certificate** for secure connections.
- **GitHub Actions** for a fully automated CI/CD pipeline.
- Easy local development workflow with a customizable structure.

---

## 📋 Prerequisites
- **Local or cloud Dev Environment** (VSCode or Gitpod)
- **GitHub Account, Secrets & Access Token** (For Automation)
- **AWS Account, S3Bucket, User & Permissions** (For Hosting and Deployment)
- **Domain & Hosted Zone** (To Route Your Traffic)

---

## 🔧 Configuration Steps

Before proceeding, ensure you have the following:
- A custom domain name registered and managed through AWS Route 53. and the (Hosted Zone ID) Walkthrough video [HERE](https://youtu.be/QnI_Xevpqts)
- Existing S3 bucket to store CloudFormation templates. [Amazon S3](https://us-east-1.console.aws.amazon.com/s3/buckets)

1. **Set-up AWS User** -
   In your AWS account create a new user specifically for your S3-Website Project. Create access keys for the user with the following credential type;
   (Third-party service You plan to use this access key to enable access for a third-party application or service that monitors or manages your AWS resources).
   Take note of your new credentials and download the credentials file.
   If you dont already have one, create an S3 bucket specifically to hold CloudFormation templates and take note of the name (any bucket will do)

2. **Set GitHub Repo Secrets** - 
   In your GitHub account create secrets corresponding to the following;
   - AWS_ACCESS_KEY_ID - (aws public key)
   - AWS_SECRET_ACCESS_KEY - (aws secret key)
   - AWS_S3_BUCKET - (website content bucket name)
   - WEBSITE_URL - (https://yoursite.com)
Also, generate your new access token. **Instructions** [HERE](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/blob/main/docs/GENERATE-GITHUB-TOKEN.md)

3. **Prepare Environment** -
   Set up your local development environment or use a cloud environment like Gitpod. **Learn how** [HERE!](https://github.com/Warner-Bell/Easy-Dev-Env-Setup/blob/main/README.md)

4. **Clone Repo** -  
   Clone the repository:

    ```
    git clone https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD.git
    ```

    Navigate to the project directory:

    ```
    cd AWS-S3Hosted-Website-CI_CD
    ```

5. **Edit Config File** -   
   Update the configuration file (`config.sh`) with the correct values such as **S3 Bucket Names**, **Domain Name**, **Hosted Zone ID**, etc.  
   See [CONFIG_SETUP.md](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/blob/main/docs/CONFIG_SETUP.md) for detailed instructions.

6. **Edit Credentials File** -   
   Edit the `.credential-file` to include your GitHub token and username, then rename it to `.credentials-file.env`.
   ```
   GITHUB_TOKEN=https://Your GitHub User-Name:Your Access Token@github.com
   ```

7. **Edit `website-prod` Directory** -   
   Use the provided **Demo Site** or replace the demo files in the `website-prod` directory with your own HTML, CSS, and JS files. Ensure your file structure aligns with the project setup for smooth deployment.

8. **Test Locally** - (**Optional**)  
   Test your changes locally. Use a tool like `http-server` to serve your static files for local testing:

    ```
    npm install -g http-server
    http-server ./website-prod
    ```

9. **Commit Changes** -  
    Commit all the changes you made to the repository:

    ```
    git add .
    git commit -m "Your New S3 Website"
    ```

10. **Create Remote Repo** -   
    Create a Remote Copy of your customized repository on GitHub by editing the `REPO_NAME=` variable in the [create-remote-repo.sh](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/blob/main/bin/create-remote-repo.sh) file, then run the script.

    ```
    ./bin/create-remote-repo.sh
    ```

12. **Push Changes and Deploy Site** - 
    Run the following commands to verify up to date and on main:
    
    ```
    git pull
    git status
    ```

    Make any necessary changes to the `website-prod` folder or any of the config files(Be Careful!)
    Commit your changes:

    ```
    git add .
    git commit -m "Final Tweaks deploy-site"
    ```

    Push your changes to trigger the deploy workflow:

    ```
    git push origin main
    ```

---
## Architecture Diagram
Here is a visual representation of the architecture being deployed.
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

    ```
    git checkout -b feature/AmazingFeature
    ```

2. Commit your changes:

    ```
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

Warner Bell - [Tap In!](https://dot.cards/warnerbell)

Project Link: [S3-Website](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD)

## 💚 Enjoyed this project? Help keep them coming!

If you'd like to support future projects, consider contributing:

[![Cash App](https://img.shields.io/badge/Cash_App-$dedprez20-00C244?style=flat&logo=cash-app)](https://cash.app/$dedprez20)

Thanks a ton for your generosity!  
Your Super Cool Cloud Builder - **Warner Bell**
