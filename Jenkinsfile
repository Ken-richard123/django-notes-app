pipeline {
    agent any

    stages {

        stage('Pull Code From GitHub') {
            steps {
                git branch: 'dev', url: 'https://github.com/Ken-richard123/django-notes-app.git'
            }
        }

        stage('Build the Docker Image') {
            steps {
                sh "docker build -t raja:v1 ."
            }
        }

        stage('Create a Container') {
            steps {
                sh "docker run -itd raja:v1"
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: '610958c1-0e5e-45cd-9ac3-0ebc91bab47c',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push the Docker Image') {
            steps {
                sh "docker tag raja:v1 kendanel/raja:v1"
                sh "docker push kendanel/raja:v1"
            }
        }

        stage('Deploy on Kubernetes') {
            steps {
                sh 'kubectl apply -f service.yml'
                sh 'kubectl apply -f deployment.yml'
            }
        }

    }
}
