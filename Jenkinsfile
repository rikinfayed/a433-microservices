// pipeline {
//     agent {
//         docker {
//             image 'golang:1.15-alpine' 
//             //args '-p 3000:3000' 
//         }
//     }
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

podTemplate(containers: [
    containerTemplate(
        name: 'jnlp', 
        image: 'jenkins/inbound-agent:latest'
        )
  ]) {

    node(POD_LABEL) {
        stage('Get a Maven project') {
            container('jnlp') {
                stage('Shell Execution') {
                    sh '''
                    echo "Hello! I am executing shell"
                    '''
                }
            }
        }

    }
}