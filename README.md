# Static Website Deployment Using Docker, Nginx & AWS EC2 with CI/CD

## Project Overview

This project demonstrates the deployment of a static website using Docker and Nginx on an AWS EC2 Linux instance. It also implements an automated Continuous Integration and Continuous Deployment (CI/CD) pipeline using GitHub Actions.

Whenever code is pushed to the GitHub repository, GitHub Actions automatically builds the Docker image, pushes it to Docker Hub and deploys the updated container to the AWS EC2 instance.

Docker Health Checks are configured to monitor the health of the running website container.

## Architecture

```text
Developer (VS Code)
        |
        v
   Git & GitHub
        |
        v
  GitHub Actions
        |
        v
  Build Docker Image
        |
        v
     Docker Hub
        |
        v
    AWS EC2 Linux
        |
        v
  Docker Container
        |
        v
    Nginx Web Server
        |
        v
   Live Static Website
```

## Technologies Used

| Technology | Purpose |
|---|---|
| HTML5 | Website structure |
| CSS3 | Website styling |
| AWS EC2 | Cloud hosting |
| Amazon Linux | Server operating system |
| Docker | Application containerization |
| Dockerfile | Custom image creation |
| Nginx | Static web server |
| Docker Hub | Image repository |
| Git | Version control |
| GitHub | Source code management |
| GitHub Actions | CI/CD automation |

## Project Structure

```text
static-website-hosting-using-docker/
│
├── .github/
│   └── workflows/
│       └── deploy.yml
│
├── Dockerfile
├── index.html
├── style.css
└── README.md
```

## Implementation Steps

### 1. Develop the Static Website

Created a static website using HTML and CSS with a homepage and project information section.

### 2. Create a Custom Docker Image

Used the official Nginx Alpine image as the base image.

```dockerfile
FROM nginx:alpine

LABEL maintainer="Cloud DevOps Project"

COPY index.html /usr/share/nginx/html/index.html

COPY style.css /usr/share/nginx/html/style.css

EXPOSE 80

HEALTHCHECK --interval=30s \
  --timeout=5s \
  --start-period=10s \
  --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
```

### 3. Build and Run Docker Container

Build the custom Docker image:

```bash
docker build -t static-website:v1 .
```

Run the Docker container:

```bash
docker run -d \
  --name static-website-container \
  -p 90:80 \
  --restart unless-stopped \
  static-website:v1
```

Verify the running container:

```bash
docker ps
```

### 4. Deploy on AWS EC2

- Launched an Amazon Linux EC2 instance.
- Installed and configured Docker.
- Built and deployed the Docker container.
- Configured EC2 Security Group inbound rules.
- Mapped EC2 port 90 to container port 80.
- Accessed the website using the EC2 public IP address.

### 5. Push Docker Image to Docker Hub

Tagged the custom Docker image:

```bash
docker tag static-website:v1 USERNAME/static-website:v1
```

Pushed the image:

```bash
docker push USERNAME/static-website:v1
```

### 6. Configure Automated CI/CD Using GitHub Actions

Created a GitHub Actions workflow to automate:

1. Source code checkout.
2. Docker Hub authentication.
3. Docker image building.
4. Docker image publishing to Docker Hub.
5. SSH connection to AWS EC2.
6. Pulling the latest application image.
7. Deploying the updated Docker container.

### 7. Docker Health Monitoring

Configured Docker HEALTHCHECK to monitor the Nginx web server.

Health check configuration:

```dockerfile
HEALTHCHECK --interval=30s \
  --timeout=5s \
  --start-period=10s \
  --retries=3 \
  CMD wget -q -O /dev/null http://127.0.0.1/ || exit 1
```

Check container health:

```bash
docker inspect \
  --format='{{.State.Health.Status}}' \
  static-website-container
```

Monitor container resource usage:

```bash
docker stats
```

Check application logs:

```bash
docker logs static-website-container
```

## CI/CD Workflow

The automated pipeline follows this process:

- Developer updates the website source code.
- Changes are pushed to the GitHub main branch.
- GitHub Actions automatically triggers the workflow.
- Docker image is built and pushed to Docker Hub.
- GitHub Actions connects to AWS EC2 using SSH.
- EC2 pulls the updated Docker image.
- The existing container is replaced with the updated version.
- The deployed website is verified through the browser.

## Key Learnings

- Linux server administration and remote access.
- Docker image creation and container management.
- Nginx configuration and static website hosting.
- AWS EC2 instance deployment.
- Git and GitHub version control.
- Docker Hub image management.
- CI/CD pipeline implementation using GitHub Actions.
- Container health checks and resource monitoring.

## Future Improvements

- Implement automatic rollback for failed deployments.
- Configure HTTPS using SSL certificates.
- Implement EC2 monitoring using AWS CloudWatch.
- Integrate Prometheus and Grafana for advanced monitoring.
- Improve deployment security using AWS Systems Manager.

## Author

**Ravendran Manogar**

Aspiring Cloud & DevOps Engineer

GitHub: https://github.com/Ravendranmanogar

