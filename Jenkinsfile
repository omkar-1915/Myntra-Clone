pipeline {
    agent any
    environment {
        SONAR_HOME = tool "sonar"
    }

    stages {
        stage('Git Checkout') {
            steps {
                 git branch: 'main', url: 'https://github.com/yashighokar1412/Myntra-Clone.git'}
        }

        stage('Sonar Quality Check') {
            steps {
                withSonarQubeEnv(credentialsId: 'sonar', installationName: 'sonar') {
                    sh "$SONAR_HOME/bin/sonar-scanner -Dsonar.projectName=myntra -Dsonar.projectKey=myntra"
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

        stage('deploy k8s') {
            steps {
                withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8s', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                   sh "kubectl apply -f deployment.yaml"
                }
            }
        }
    }
}
