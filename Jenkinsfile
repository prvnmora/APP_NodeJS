pipeline {
    agent any
    environment {
        //IMAGE_NAME = "prvnmora/simple-app"
        AWS_REGION = "us-east-1"
    }
    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Clone Repository') {
            steps {
               checkout changelog: false, poll: false, scm: scmGit(branches: [[name: '*/main']], extensions: [], 
               userRemoteConfigs: [[credentialsId: 'GitHub-Cred', url: 'https://github.com/prvnmora/APP_NodeJS.git']])
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }
         stage('Login to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker push ${IMAGE_NAME}"
                }
            }
        }

        stage('Cleanup') {
            steps {
                sh "docker rmi ${IMAGE_NAME}"
            }
        }
        
        /*stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml'
            }
        }*/
    }
}
