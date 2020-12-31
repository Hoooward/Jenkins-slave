pipeline {
  agent {
    label "jenkins-slave"
  }
  environment {
    dockerRepo = 'http://registry.cn-zhangjiakou.aliyuncs.com'
    dockerCreds = 'lzm-dockerhub-aliyun'
    dockerName = 'test'
    dockerNamespace = 'datasafe'
  }

  stages {
      stage('Build Docker Image') {
        steps {
          script {
            container('docker') {
              
            docker.withRegistry(dockerRepo, dockerCreds) {
              dockerImage = docker.build(dockerNamespace + '/' + dockerName + ':' + env.BRANCH_NAME, '--pull .')
              dockerImage.push()
            }
            }
          }
        }
      }
  }
}
