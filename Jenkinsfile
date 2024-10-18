pipeline {
    agent any
    stages {
        stage('Git Checkout') {
            steps {
                git 'https://github.com/yashighokar1412/Myntra-clone.git'
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
                withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: 'nodejs', contextName: '', credentialsId: 'k8s', namespace: '', serverUrl: '']]) {
                    sh "kubectl apply -f deployment.yml"
                }
            }
        }
    }
}
