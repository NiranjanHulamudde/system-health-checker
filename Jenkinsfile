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
    }
}
