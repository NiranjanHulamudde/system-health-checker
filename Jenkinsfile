pipeline {
    agent any

    stages {
        stage('Checkout scm') {
            steps {
                checkout scm
            }
        }
        stage('Test') {
            steps {
                sh './memory-health-checker'
            }
        }
        stage('Building the Image') {
            steps {
                echo 'Building the docker image of memory checker'
                sh 'docker build -t memory-checker:latest .'
            }
        }
            }
        }
