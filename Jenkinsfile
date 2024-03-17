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
        image: 'docker:dind',
        command: 'sleep',
        args: '99d' 
        ),
  ]) {

    env.CGO_ENABLED=0
    env.REGISTRY_URL="ghcr.io"

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
            stage('build app') {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'GHCR_CREDENTIALS',
                        usernameVariable: 'REGISTRY_USER', passwordVariable: 'REGISTRY_PASSWORD'
                    )
                ]) {
                    sh ''' 
                        echo ${IMAGE_BRANCH_TAG}
                        echo ${REGISTRY_PASSWORD} | docker login ${REGISTRY_URL} -u ${REGISTRY_USER} --password-stdin
                        // docker push ${IMAGE_BRANCH_TAG}.${env.GIT_COMMIT[0..6]}
                        // docker tag ${IMAGE_BRANCH_TAG}.${env.GIT_COMMIT[0..6]} ${IMAGE_BRANCH_TAG}
                        // docker push ${IMAGE_BRANCH_TAG}
                    '''
                }
            }
        }
    }
}