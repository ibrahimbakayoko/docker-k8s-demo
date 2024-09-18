pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "dnais1210/docker-k8s-demo"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ibrahimbakayoko/docker-k8s-demo.git'
            }
        }
        
        stage('Build Maven Project') {
            agent {
                docker {
                    image 'maven:3.8.6-openjdk-17'
                    args '-v /root/.m2:/root/.m2' // Utilisation du cache Maven pour accélérer la construction
                }
            }
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-token', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
                    script {
                        docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-token') {
                            docker.image("${DOCKER_IMAGE}:latest").push()
                        }
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Exécuter des commandes de déploiement Kubernetes
                    sh 'kubectl apply -f k8s/deployment.yaml'
                }
            }
        }
    }
    
    post {
        always {
            cleanWs() // Nettoyage du workspace après chaque build pour éviter des accumulations inutiles
        }
    }
}
