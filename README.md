
## 🔄 Workflows

### 🆕 Deploy Site
Manually triggered workflow to deploy the website. (Takes 15mins)

### 🔄 Update Site
Automatically updates the S3 bucket and invalidates CloudFront distribution when changes are pushed to the `main` branch in the `website-prod` directory.

### 🗑️ Destroy Site
Manually triggered workflow to tear down the website infrastructure.
# S3 Hosted Website Template

This project provides a template for hosting a static website on Amazon S3 with CloudFront distribution, using GitHub Actions for automated deployment and updates.

## 🚀 Features

- Automated deployment to Amazon S3
- CloudFront distribution for fast content delivery
- OriginAccessControl(OAC) for secure delivery
- GitHub Actions for CI/CD
- Easy local development workflow

## 📋 Prerequisites

- Basic Dev eviroment setup (How-to Doc ---> DEV_ENV_SETUP.md)
- GitHub account and a generated access token (How-to Doc ---> GENERATE-GITHUB-TOKEN.md)
- AWS account with appropriate permissions
- A domain name and a RT53 trusted zone (if you buy your domain from aws no further config necessary)
- Basic knowledge of HTML, CSS, and JavaScript (for website development)

## 🔄 Workflows

### 🆕 Deploy Site
Manually or comment triggered workflow to deploy the website.

### 🔄 Update Site
Automatically updates the S3 bucket and invalidates CloudFront distribution when changes are pushed to the `main` branch in the `website-prod` directory.

### 🗑️ Destroy Site
Manually or comment triggered workflow to tear down the website infrastructure.

## 🖥️ Local Development


1. Clone the repository:

Copy

Insert at cursor
markdown
git clone https://github.com/your-username/your-repo-name.git

2. Navigate to the project directory:

Copy

Insert at cursor
text
cd your-repo-name

3. Update config file with appropriate variables
4. Make changes in the `website-prod` directory add your website files to the structure
5. Test your changes locally
6. Commit your changes:

Copy

Insert at cursor
text
git add .
git commit -m "deploy-site"

6. Push your changes to trigger the update workflow:

Copy

Insert at cursor
text
git push origin main


## 📚 Additional Resources

- [Amazon S3 Documentation](https://docs.aws.amazon.com/s3/)
- [CloudFront Documentation](https://docs.aws.amazon.com/cloudfront/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Here's how you can contribute:

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

Please feel free to check the [issues page](link-to-issues) for any open issues or feature requests.

## 📝 License

This project is [MIT](link-to-license) licensed.

## 📬 Contact

Your Name - [@your_twitter](https://twitter.com/your_twitter) - email@example.com

Project Link: [https://github.com/your-username