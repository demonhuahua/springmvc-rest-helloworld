def label = "slave-${UUID.randomUUID().toString()}"

podTemplate(label: label, containers: [
  containerTemplate(name: 'maven', image: 'maven:3.6-alpine', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'kubectl', image: 'cnych/kubectl', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'helm', image: 'cnych/helm', command: 'cat', ttyEnabled: true)
], volumes: [
  hostPathVolume(mountPath: '/root/.m2', hostPath: '/var/run/m2'),
  hostPathVolume(mountPath: '/home/jenkins/.kube', hostPath: '/root/.kube'),
  hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
  hostPathVolume(mountPath: '/root/.kube', hostPath: '/root/.kube')
]) {
  node(label) {
    def myRepo = checkout scm
    def gitCommit = myRepo.GIT_COMMIT
    def gitBranch = myRepo.GIT_BRANCH

    def GIT_TAG = ""

    stage('Git Tag') {

      GIT_TAG = sh(returnStdout: true,script: 'git describe --tags --always').trim()

      echo "${GIT_TAG}"

      if("${GIT_TAG}"==""){

        echo "ERROR: git tag not null!"

      }

    }
    
    stage('单元测试') {
      echo "测试阶段"
    }
    stage('代码编译打包') {
      container('maven') {
        echo "代码编译打包阶段"
        sh "mvn clean compile"
        sh "mvn clean package"
        sh "pwd"
        sh "ls -l"
      }
    }
    stage('构建 Docker 镜像') {
      container('docker') {
        echo "构建 Docker 镜像阶段"
        sh "pwd"
        sh "ls -l"
        sh "ls -l target"
        sh "docker build -t cloud/myown:v4 ."
        sh "docker images"
        
      }
    }
    stage('运行 Kubectl') {
      container('kubectl') {
        echo "查看 K8S 集群 Pod 列表"
        sh "pwd"
        sh "df -h"
        sh "ls "
        sh "ls /home/jenkins/.kube"
        sh "cat /home/jenkins/.kube/config"
        sh "id"
        sh "ls /root/.kube"
        sh "kubectl get pod"
      }
    }
    stage('运行 Helm') {
      container('helm') {
        echo "查看 Helm Release 列表"
        sh "echo helm list"
        sh "helm list"
        sh "pwd"
        sh "ls -l"
      }
    }
    
    stage('运行 jnlo') {
      container('jnlp') {
        echo "查看jnlp"
        sh "echo jnlp"
        sh "id"
        sh "pwd"
        sh "ls -l"
        sh "uname -a"
        sh "ls /usr/bin"
        sh "ls /bin"
        sh "ls /sbin"
        sh "java -version"
        sh "uptime"
        sh "whoami"
        sh "hostname"
        sh "netstat -nr"
        sh "id root"
        sh "w"
        sh "ifconfig -a"
        //sh "chmod 4755 /bin/busybox"
        //sh "su - root"
        
      }
    }
    
  }
}
