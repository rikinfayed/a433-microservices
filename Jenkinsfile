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
    containerTemplate(
        name: 'docker', 
        image: 'docker:dnd',
        command: 'sleep',
        args: '99d' 
        ),
  ]) {

    env.CGO_ENABLED=0

    node(POD_LABEL) {
        stage('lint-dockerfile') {
            git url: 'https://github.com/rikinfayed/a433-microservices.git', branch: 'karsajobs'
            stage ('lint dockerfile') {
                container('hadolint') {
                    sh '''
                    hadolint *Dockerfile* | tee -a hadolint_lint.txt
                    '''
                }
            }    
        }
        stage('test-app') {
            container('golang') {
                stage('test-app') {
                    sh '''
                        mkdir -p /go/src/github.com/rikinfayed
                        ln -s `pwd` /go/src/github.com/rikinfayed/a433-microservices
                        cd /go/src/github.com/rikinfayed/a433-microservices && go clean --cache && go mod download && go test -v -short --count=1 $(go list ./...)
                    '''
                }
            }
        }
        stage('build-app-karsajobs') { 
            steps {
                sh '''
                    pwd
                    ls
                '''
            }
            // stage('build app') {
            //     sh '''
            //         pwd
            //         ls
            //     '''
            // }
        }
    }
}