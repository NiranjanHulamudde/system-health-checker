pipeline {
    agent any

    environment {
        DOCKER_USER = 'niranjanhulamudde'
        DOCKER_IMAGE = 'memory-checker'
        IMAGE_TAG = 'latest'
    }

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
                sh "docker build -t ${DOCKER_USER}/${DOCKER_IMAGE}:${IMAGE_TAG} ."
                
        stage('Pushing the image to dockerhub')
              steps {
                  echo 'Pushing the image to dockerhub'
                  withCredentials([usernamePassword(credentialsID : 'ba2f5e5b-9bc3-4671-aabe-f7d583d9d6d9',
                                                    usernameVariable : 'DH_USER',
                                                    usernamePassword : 'DH_PASSWORD')]) {
                      sh "echo \$DH_PASSWORD | docker login -u \$DH_USER --password-stdin"
                      sh "docker push ${DOCKER_USER}/${DOCKER_IMAGE}:${IMAGE_TAG}"
                  
              }
            }
        }
    } 
} 
