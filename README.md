![Deploy Site](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/actions/workflows/deploy.yml/badge.svg)

![Update Site](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/actions/workflows/update.yml/badge.svg)

# 🌐 EASY!!! - `AWS S3-Hosted Website CI\CD` - EASY!!!

This project provides a super easy solution for hosting a static website on Amazon S3, using a DevOps workflow, IAC & GitHub Actions for automated deployment and updates. **All you need is a domain and a hosted zone!**

**Note:** *All of the code was created with the assistance of **Amazon Q***

## 🔄 Workflows

### 🆕 Deploy Site
Manually triggered or comment-triggered workflow to deploy the website.

- **How to Trigger**: You can trigger this workflow through the GitHub Actions tab or by adding a comment like `deploy-site` on a commit and push it to origin.

### 🔄 Update Site
Automatically updates the **S3 bucket** and invalidates **CloudFront distribution** when changes to the `website-prod` directory are pushed to the `main`.

- **Note**: Ensure environment variables such as `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_REGION` are set in your GitHub repository secrets for proper CI/CD functionality. Follow this guide to set environment variables: [GitHub Secrets Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets).

### 🗑️ Destroy Site
Manually or comment-triggered workflow to tear down the website infrastructure.

- **How to Trigger**: You can trigger this workflow through the GitHub Actions tab or by adding a comment like `destroy-site` on a commit and push it to origin.

## 🚀 Features
- Automated deployment to **Amazon S3** using **CloudFormation**.
- **CloudFront** distribution for fast content delivery.
- **Origin Access Control (OAC)** for secure delivery.
- **SSL/TLS Certificate** for secure connections.
- **GitHub Actions** for a fully automated CI/CD pipeline.
- Easy local development workflow with a customizable structure.

## 📋 Prerequisites
- Local Dev Environment or Gitpod - (To Build on)
- GitHub Account & Access Token - (To Use Automation)
- AWS Account & Permissions - (To Host and Deploy on)
- Domain & Hosted Zone - (To Route Your Traffic)

## 🔧 Configuration Steps
- Prepare Environment
- Clone Repo
- Edit Credentials File
- Edit website-prod Directory
- Commit Changes
- push Changes

##  Tips
- Basic Dev eviroment setup (How-to Doc ---> DEV_ENV_SETUP.md)
- A domain name and a RT53 trusted zone (How-to Vid --->  )
- AWS account with appropriate permissions (How-to Vid --->  )
- GitHub account for the github actions to work (go to https://github.com and create account)
- Basic knowledge of HTML, CSS, and JavaScript for website development (you good if you can copy & paste!)


## Prelim Setup

### AWS
- An **AWS account** and your user imbued with appropriate permissions (IAM Role with **admin** or full access to **CloudFormation**, **S3**, **CloudFront**, **Lambda**, **DynamoDB**, **Certificate Manager**, and **Route 53**).
- A domain name and a **Route 53** hosted zone (If domain purchased from AWS, no additional configuration necessary).
 
### GitHub
- **GitHub account** and a generated access token. See [GENERATE-GITHUB-TOKEN.md](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/blob/d2a553a7f9f4d547491e3b45b0b4778c2d1a9114/GENERATE-GITHUB-TOKEN.md) for instruction.

### Local Dev
- Set up or update your local dev environment with the latest versions of apps and libraries

### Website Files (Demo Provided)
- Update **website files** by replacing the demo files with your own html, css, and java files. (How-to Doc ---> DEV_ENV_SETUP.md)


---
## Prepare Environment
You will need a Dev envirionment from which to conduct your DevOps and CI\CD processes. You can use the How-to Doc ---> DEV_ENV_SETUP.md in this repo to learn how to set up and update your local dev environment with the latest versions of apps and libraries.

### Clone Repo
Clone the repository:

    ```bash
    git clone https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD.git
    ```

Navigate to the project directory:

    ```bash
    cd your-repo-name
    ```

### Edit Credentials File
Be sure that you updated the configuration file (`config.sh`) with the correct values such as **S3 Bucket Names**, **Domain Name**, **Hosted Zone ID**, and other variables. 

Update the configuration file with appropriate variables as explained in [CONFIG_SETUP.md](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/blob/f070c8c586f654f576928a14680486e3005c005b/CONFIG_SETUP.md).

### Edit website-prod Directory
Use the included **Demo Site** or add your own website files to the `website-prod` directory. Ensure your file structure aligns with the project setup for smooth deployment.

### Testing and Deployment
Test your changes locally. You can use a tool like `http-server` to serve your static files for testing:

    ```bash
    npm install -g http-server
    http-server ./website-prod
    ```
### Commit Changes
Commit all the changes you made to the repo.

    ```bash
    git commit - m "Your New S3 Website"
    ```
### Create Remote Repo
Create a Remote Copy of your Customized repo on GitHub by editing the `REPO_NAME=` variable in the [create-remote-repo.sh](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD/blob/966af9c5136f472f4341ea60cd545249307d1344/create-remote-repo.sh) file and then running the script.

### push Changes and Deploy Site
Commit your changes:

    ```bash
    git add .
    git commit -m "deploy-site"
    ```

Push your changes to trigger the deploy workflow:

    ```bash
    git push origin main
    ```

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

4. Open a pull request.

Feel free to check the [issues page](TBD) for any open issues or feature requests.

---

## 📝 License

This project is licensed under the [MIT License](TBD).

---

## 📬 Contact

Warner Bell - [Tap In!](https://dot.cards/warnerbell) - yo@warnerbell.com

Project Link: [S3-Website](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD)
