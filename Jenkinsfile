/**
 * This pipeline describes a multi container job, running Maven and Golang builds
 */

podTemplate(yaml: """
apiVersion: v1
kind: Pod
spec:
  volumes:
    - name: nfs
      persistentVolumeClaim:
        claimName: maven-repo
    - name: curl
      hostPath:
        path: /usr/local/bin/curl
  containers:
  - name: maven
    image: maven:3.3.9-jdk-8-alpine
    command: ['cat']
    tty: true
    volumeMounts:
    - mountPath: "/tmp"
      name: nfs
    - mountPath: "/usr/local/bin/curl"
      name: curl
    env:
    - name: POD_OWN_IP_ADDRESS
      valueFrom:
        fieldRef:
          fieldPath: status.podIP
    - name: POD_OWN_NAME
      valueFrom:
        fieldRef:
          fieldPath: metadata.name
    - name: POD_OWN_NAMESPACE
      valueFrom:
        fieldRef:
          fieldPath: metadata.namespace
  - name: golang
    image: golang:1.8.0
    command: ['cat']
    tty: true
    volumeMounts:
    - mountPath: "/tmp"
      name: nfs
"""
  ) {

  node(POD_LABEL) {
    parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
    }
    
    stage('Clone') {
    echo "1.Clone Stage"
    def myRepo = checkout scm
    def gitCommit = myRepo.GIT_COMMIT
    def gitBranch = myRepo.GIT_BRANCH
    echo "{gitCommit}"
    echo "${gitBranch}"
    //git url: "https://github.com/demonhuahua/springmvc-rest-helloworld.git"
    sh "pwd"
    sh "ls"
    sh "cat README"
    script {
        
        build_tag = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
    }
    echo "${build_tag}"
    }
    
    stage('Build a Maven project') {
 
      sh "pwd"
      sh "ls"
      result = sh returnStdout: true ,script: "git rev-parse --short HEAD"
      result = result.trim()
      echo "${result}"
      echo "${build_tag}"
      sh "buildtag=`git rev-parse --short HEAD`"
      echo "begin"
      echo "${JENKINS_URL}"
      echo "${JENKINS_SECRET}"
      echo "${JENKINS_AGENT_NAME}"
      echo "${JENKINS_NAME}"
      echo "${JOB_NAME}"
      //git 'https://github.com/jenkinsci/kubernetes-plugin.git'
      container('maven') {
        echo "maven start"
        //ret = sh returnStdout: true ,script: "curl http://10.97.164.35:5000/v2/busybox/tags/list | grep v1.0"
        ret = sh(script: "curl http://10.97.164.35:5000/v2/busybox/tags/list | grep v1.0", returnStatus: true)
        echo "${ret}"
        //ret = ret.trim()
        //echo "${ret}"
        if ("${ret}"=="0"){
        echo "Has Data!"
         }
        //sh 'mvn -B clean package'
        sh 'echo maven'
        sh 'pwd'
        sh 'touch test'
        sh 'ls'
        sh 'ls ../'
        sh 'ls /tmp'
        sh 'echo yhz3 > /tmp/yhz3.txt'
        //sh 'env'
        //sh 'echo ${testchoice}'
        sh 'echo ${yhztag}'
        sh 'echo ${yhz_revision:0:8}'
        sh 'echo ${ExtendChoice}'
      }
    }

    stage('Build a Golang project') {
      //git url: 'https://github.com/terraform-providers/terraform-provider-aws.git'
      container('golang') {
        sh """
        pwd
        ls
        mkdir -p /go/src/github.com/terraform-providers
        ln -s `pwd` /go/src/github.com/terraform-providers/terraform-provider-aws
        ls
        echo yhz4 > /tmp/yhz4.txt
        env
        echo done
        """
        echo "${result}"
        echo "${build_tag}"
      }
    }

  }
}
