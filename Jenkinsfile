pipeline {
    agent any

    environment {
        IMAGE_NAME = "local-memory-checker"
        IMAGE_TAG  = "latest"
    }

    stages {
        stage('1. Code Checkout') {
            steps {
                echo 'Pulling the latest code commit changes from GitHub...'
                checkout scm
            }
        }

        stage('2. Build Container') {
            steps {
                echo 'Building the monitoring system Docker image...'
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('3. Run Diagnostics') {
            steps {
                echo 'Executing the Containerized System Memory Checker Script...'
                script {
                    try {
                        // --pid=host lets the container monitor your real VM processes
                        sh "docker run --rm --pid=host ${IMAGE_NAME}:${IMAGE_TAG}"
                        currentBuild.result = 'SUCCESS'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        echo "Execution failed. Review error output logs."
                    }
                }
            }
        }
    }

    post {
        always {
            echo '==== Pipeline Execution Finished ===='
            echo "Final Build Pipeline Status: ${currentBuild.result}"
        }
    }
}
