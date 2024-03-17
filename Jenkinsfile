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
    containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true)
  ],
  volumes: [
    hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')
  ]) {

    env.CGO_ENABLED=0
    env.REGISTRY_URL="ghcr.io"
    env.IMAGENAME="karsajobs:latest"

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
            gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
            container('docker') {
                stage('build image') {
                    withCredentials([
                        usernamePassword(
                            credentialsId: 'GHCR_CREDENTIALS',
                            usernameVariable: 'REGISTRY_USER', passwordVariable: 'REGISTRY_PASSWORD'
                        )
                    ]) { 
                        sh ''' 
                            docker build -t $IMAGENAME . && \
                            docker image ls && \
                            docker tag $IMAGENAME ghcr.io/rikinfayed/$IMAGENAME
                            echo ${REGISTRY_PASSWORD} | docker login ${REGISTRY_URL} -u ${REGISTRY_USER} --password-stdin
                            docker push ghcr.io/rikinfayed/$IMAGENAME                                                   
                        '''
                    }
                }
            }
        }
    }
}