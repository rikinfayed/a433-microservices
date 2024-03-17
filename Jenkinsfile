// pipeline {
//     agent {
//         docker {
//             image 'golang:1.15-alpine' 
//             //args '-p 3000:3000' 
//         }
//     }
//     agent any
//     stages {
//         stage('Build') { 
//             steps {
//                 sh 'go mod download'
//             }
//         }
//         stage('Test') { 
//             steps {
//                 sh 'go test -v -short --count=1 $(go list ./...)'
//             }
//         }
//         // stage('Deliver') { 
//         //     step {
//         //         sh 'go test -v -short --count=1 $(go list ./...)'
//         //     }
//         // }
//     }
// }
// podTemplate {
//     node(POD_LABEL) {
//         stage('Run shell') {
//             sh 'echo hello world'
//         }
//     }
// }

// podTemplate(containers: [
//     containerTemplate(
//         name: 'jnlp', 
//         image: 'jenkins/inbound-agent:latest'
//         )
//   ]) {

//     node(POD_LABEL) {
//         stage('Get a Maven project') {
//             container('jnlp') {
//                 stage('Shell Execution') {
//                     sh '''
//                     echo "Hello! I am executing shell"
//                     '''
//                 }
//             }
//         }

//     }
// }

podTemplate(containers: [
    containerTemplate(
        name: 'hadolint', 
        image: 'hadolint/hadolint:latest-debian',
        command: 'sleep',
        args: '99d' 
        ),
    containerTemplate(
        name: 'golang', 
        image: 'golang:1.15-alpine',
        command: 'sleep',
        args: '99d' 
        ),
  ]) {

    node(POD_LABEL) {
        stages {
            stage('Run Docker') {
                stages {
                    git url: 'https://github.com/rikinfayed/a433-microservices.git', branch: 'karsajobs'
                    stage('Lint Dockerfile') {
                        steps{
                            container('hadolint') {
                                sh '''
                                hadolint *Dockerfile* | tee -a hadolint_lint.txt
                                '''
                            }
                        }
                        post {
                            failure { name: 'Build Docker Image', state: 'failed' }
                            success { name: 'Build Docker Image', state: 'success' }
                        }
                    }
                }
            }
        }
        // stage('lint-dockerfile') {
        //     git url: 'https://github.com/rikinfayed/a433-microservices.git', branch: 'karsajobs'
        //     stage ('Lint dockerfile') {
        //         container('hadolint') {
        //             sh '''
        //             hadolint *Dockerfile* | tee -a hadolint_lint.txt
        //             '''
        //         }
        //     }
            
        // }
        // stage('Build') {
        //     //git 'https://github.com/spring-projects/spring-petclinic.git'
        //     git url: 'https://github.com/rikinfayed/a433-microservices.git', branch: 'karsajobs'
        //     container('golang') {
        //         stage('Install depencies') {
        //             // sh '''
        //             // echo "maven build"
        //             // '''       
        //             //sh 'go mod download'
        //             sh '''
        //                 mkdir -p /go/src/github.com/rikinfayed
        //                 ln -s `pwd` /go/src/github.com/rikinfayed/a433-microservices
        //                 cd /go/src/github.com/rikinfayed/a433-microservices && go mod download
        //             '''
        //         }
        //     }
        // }
        // post {
        //     always {
        //         archiveArtifacts 'hadolint_lint.txt'
        //     }
        // }

        // stage('Get a Python Project') {
        //     git url: 'https://github.com/hashicorp/terraform.git', branch: 'main'
        //     container('python') {
        //         stage('Build a Go project') {
        //             sh '''
        //             echo "Go Build"
        //             '''
        //         }
        //     }
        // }

    }
}