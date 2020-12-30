pipeline {
  agent {
    label "slave"
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
            
            docker.withRegistry(dockerRepo, dockerCreds) {
              dockerImage = docker.build(dockerNamespace + '/' + dockerName + ':' + env.BRANCH_NAME, '--pull .')
              dockerImage.push()
            }
          }
        }
      }
  }
}
