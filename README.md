# Containerized System Memory Checker CI/CD Pipeline

An automated, cloud-native DevOps monitoring architecture that packages an active Linux performance shell script into an isolated container and manages continuous integration builds natively via an automated Jenkins pipeline linked over webhooks.

## 🛠️ Architecture Workflow Topology
1. **Developer Workstation:** Code updates are pushed to the remote GitHub repository tracking loop.
2. **GitHub Webhook Trigger:** An instant webhook notification fires out to an active `ngrok` secure tunnel endpoint.
3. **Jenkins Automation Server:** The `ngrok` proxy routes the handshake payload directly to a local private Jenkins daemon server.
4. **Docker Container Execution:** Jenkins checks out the repository codebase, provisions a clean Alpine Linux container image runtime, executes the memory checks utilizing real-time host process mapping metrics, and outputs runtime alerts.

---

## 📂 Project Repository Matrix

### 1. The Core Memory Monitor (`memory-health-checker`)
A shell script utilizing `awk` conditional parameters to filter system resource tracking data for decimal percentages:
```bash
#!/bin/bash
echo "==== System Memory Checker ===="
echo "Logged time - \$(date)"
echo

memory_usage=\$(ps aux --sort=-%mem | awk 'NR==2 {print \$3}')

if [ -z "\$memory_usage" ]; then
    memory_usage=0.0
fi

if awk -v mem="\$memory_usage" 'BEGIN {exit !(mem > 80.0)}'
then
    echo "High Memory usage (\$memory_usage%), need action."
else
    echo "Normal Memory usage (\$memory_usage%), no action required."
fi
```

### 2. The Container Configuration Blueprint (`Dockerfile`)
An optimized file structure that encapsulates runtime scripts cleanly inside an ultra-lean Alpine baseline environment:
```dockerfile
FROM alpine:3.21
RUN apk add --no-cache bash gawk
WORKDIR /app
COPY memory-health-checker .
RUN chmod +x memory-health-checker
CMD ["./memory-health-checker"]
```

### 3. The Orchestration Master Framework (`Jenkinsfile`)
A declarative multi-stage automation structure defining continuous build validation cycles:
```groovy
pipeline {
    agent any
    environment {
        IMAGE_NAME = "local-memory-checker"
        IMAGE_TAG  = "latest"
    }
    stages {
        stage('1. Code Checkout') {
            steps {
                checkout scm
            }
        }
        stage('2. Build Container') {
            steps {
                sh "docker build -t \({IMAGE_NAME}:\){IMAGE_TAG} ."
            }
        }
        stage('3. Run Diagnostics') {
            steps {
                script {
                    try {
                        sh "docker run --rm --pid=host \({IMAGE_NAME}:\){IMAGE_TAG}"
                        currentBuild.result = 'SUCCESS'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                    }
                }
            }
        }
    }
}
```

---

## ⚡ Setup & Verification Execution Loop

### Step A: Granting Jenkins Rights to the Host Docker Daemon
To prevent structural workspace runtime blockades, map the Jenkins engine user profile to root container execution sockets:
```bash
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```

### Step B: Launching the Secure Proxy Port Forward Webhook
Expose the internal server instance port to accept payload handshakes securely from the open internet:
```bash
ngrok http 8080
```
*Configure the generated secure HTTPS domain path link straight into GitHub Webhooks matching the absolute routing syntax:* `https://<your_subdomain>.ngrok-free.app/github-webhook/` [1]
