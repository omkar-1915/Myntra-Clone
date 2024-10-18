pipeline {
    agent any
    environment {
        SONAR_HOME = tool "sonar"
    }

    stages {
        stage('Git Checkout') {
            steps {
                git 'https://github.com/yashighokar1412/Myntra-Clone.git'
            }
        }

        stage('Sonar Quality Check') {
            steps {
                withSonarQubeEnv(credentialsId: 'sonar', installationName: 'sonar') {
                    sh "$SONAR_HOME/bin/sonar-scanner -Dsonar.projectName=nodejs -Dsonar.projectKey=nodejs"
                }
            }
        }

        stage('Docker Image') {
            steps {
                withDockerRegistry(credentialsId: 'docker', url: 'https://index.docker.io/v1/') {
                    sh "docker build -t yashthedocker/myntra ."
                    sh "docker push yashthedocker/myntra:latest"
                    sh "docker images"
                }
            }
        }
    
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withAWS(credentials: 'aws', region: 'us-east-1') {
                        withKubeConfig(caCertificate: '', 
                                       clusterName: 'myntra', 
                                       contextName: 'arn:aws:eks:us-east-1:084375558659:cluster/myntra', 
                                       credentialsId: 'k8s', 
                                       namespace: 'default', 
                                       restrictKubeConfigAccess: false, 
                                       serverUrl: 'https://711A4DFE055C0284F9DA129EDB9E3386.gr7.us-east-1.eks.amazonaws.com') {
                            sh "kubectl apply -f deployment.yml"
                            sh "kubectl apply -f service.yml"
                            sh "kubectl get service"
                        }
                    }
                }
            }
        }
    }
}
