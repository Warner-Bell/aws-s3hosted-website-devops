## 🔄 Workflows

### 🆕 Deploy Site
Manually triggered workflow to deploy the website. (Takes approximately 15 minutes).

### 🔄 Update Site
Automatically updates the S3 bucket and invalidates CloudFront distribution when changes are pushed to the `main` branch in the `website-prod` directory. 

- **Note**: Ensure environment variables like `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` are set in your GitHub repository for proper CI/CD functionality.

### 🗑️ Destroy Site
Manually triggered workflow to tear down the website infrastructure.

# S3 Hosted Website Template

This project provides a template for hosting a static website on Amazon S3 with CloudFront distribution, using GitHub Actions for automated deployment and updates.

## 🚀 Features

- Automated deployment to Amazon S3.
- CloudFront distribution for fast content delivery.
- Origin Access Control (OAC) for secure delivery.
- GitHub Actions for CI/CD pipeline.
- Easy local development workflow with a customizable structure.

## 📋 Prerequisites

- Basic development environment setup (How-to Doc ---> `DEV_ENV_SETUP.md`)
- GitHub account and a generated access token (How-to Doc ---> `GENERATE-GITHUB-TOKEN.md`)
- AWS account with appropriate permissions (IAM Role with S3, CloudFront, and Route 53 access).
- A domain name and a Route 53 hosted zone (If purchased from AWS, no additional configuration necessary).
- Basic knowledge of HTML, CSS, and JavaScript (for website development).

## 🔄 Workflows

### 🆕 Deploy Site
Manually or comment-triggered workflow to deploy the website. This can be done by executing the workflow through the GitHub Actions tab.

### 🔄 Update Site
Automatically updates the S3 bucket and invalidates the CloudFront distribution when changes are pushed to the `main` branch in the `website-prod` directory. Ensure the changes follow proper versioning and compatibility checks.

### 🗑️ Destroy Site
Manually or comment-triggered workflow to tear down the website infrastructure. This removes the S3 bucket and disassociates the CloudFront distribution.

## 🖥️ Local Development

1. Clone the repository:

    ```bash
    git clone https://github.com/your-username/your-repo-name.git
    ```

2. Navigate to the project directory:

    ```bash
    cd your-repo-name
    ```

3. Update the configuration file with appropriate variables.
4. Add your website files to the `website-prod` directory. Ensure your file structure aligns with the project setup for smooth deployment.
5. Test your changes locally. You can use a tool like `http-server` to serve your static files for testing:

    ```bash
    npm install -g http-server
    http-server ./website-prod
    ```

6. Commit your changes:

    ```bash
    git add .
    git commit -m "deploy-site"
    ```

7. Push your changes to trigger the update workflow:

    ```bash
    git push origin main
    ```

## 📚 Additional Resources

- [Amazon S3 Documentation](https://docs.aws.amazon.com/s3/)
- [CloudFront Documentation](https://docs.aws.amazon.com/cloudfront/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [AWS IAM Role Permissions Setup](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html)
- [Route 53 Hosted Zone Documentation](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/Welcome.html)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Here's how you can contribute:

1. Fork the Project.
2. Create your feature branch:

    ```bash
    git checkout -b feature/AmazingFeature
    ```

3. Commit your changes:

    ```bash
    git commit -m 'Add some AmazingFeature'
    ```

4. Push to the branch:

    ```bash
    git push origin feature/AmazingFeature
    ```

5. Open a pull request.

Feel free to check the [issues page](link-to-issues) for any open issues or feature requests.

## 📝 License

This project is [MIT](link-to-license) licensed.

## 📬 Contact

Warner Bell - [Tap In!](https://dot.cards/warnerbell) - yo@warnerbell.com

Project Link: [S3-Website](https://github.com/Warner-Bell/AWS-S3Hosted-Website-CI_CD)
