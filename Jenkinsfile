pipeline {
    agent {
        docker {
            image 'golang:1.15-alpine' 
            //args '-p 3000:3000' 
        }
    }
    stages {
        stage('Build') { 
            steps {
                sh 'go mod download'
            }
        }
        stage('Test') { 
            steps {
                sh 'go test -v -short --count=1 $(go list ./...)'
            }
        }
        // stage('Deliver') { 
        //     step {
        //         sh 'go test -v -short --count=1 $(go list ./...)'
        //     }
        // }
    }
}