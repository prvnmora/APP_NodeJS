pipeline {
    agent master
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
        stage('Push to Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: 'https://hub.docker.com/repositories/prvnmora']) {
                    sh 'docker push $IMAGE_NAME'
                }
            }
        }
        /*stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml'
            }
        }*/
    }
}
