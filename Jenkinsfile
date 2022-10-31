
/* import shared library */
//@Library('jenkins-shared-library')_

pipeline {
  agent {
      label 'oe-build-gm-ccu-PoC'
  }
  
  options {
    buildDiscarder(logRotator(numToKeepStr: '30', artifactNumToKeepStr: '10'))
    durabilityHint('PERFORMANCE_OPTIMIZED')
    copyArtifactPermission('smoke-test')
  }

  environment {
    TEAMS_WEB_HOOK = 'https://creatorab.webhook.office.com/webhookb2/3faa5c1d-9e2b-4eca-a07e-6149c1bf818e@41edc297-cc3a-4756-9da1-a9eb6b1ca80d/IncomingWebhook/d52f17b71edd4692b18815f4ddce8788/d7a8b56a-cbe9-447a-b247-149d00841a7d'
  }
  
  stages {
    stage('Build setup') {
       //when { expression { false } }
       steps {
        sh 'echo "Build setup"'
         //cleanWs()
         //checkout scm
       }
    }
    // stage('Checkout SCM') {
    //    //when { expression { false } }
    //    steps {
    //     sh 'echo "Gerrit checkout"'
    //      //checkout scm
    //    }
    // }
    stage('Build Docker Images') {
      steps {
        sh 'echo "Build docker images"'
        // docker build .
      }
    }
    stage('Bitbake build') {
      steps {
        sh '''
           echo "...Bitbake/Yocto Build..."
           # mkdir -p deploy-sama5d27-wlsom1-ek
           # touch deploy-sama5d27-wlsom1-ek/build_file.obj
           # date >> deploy-sama5d27-wlsom1-ek/build_file.obj

           sh scripts_pipelines/bitbake_build/main.sh
           echo "...Build Done..."
        '''
      }
    }
    stage('Unit Tests') {
      when { expression { false } }
      steps {
        sh '''
           echo "Started Unit Tests"
           sh scripts_pipelines/unit_tests/main.sh
           echo "Finished Unit Tests"
        '''
      }
    }
    stage('Smoke Test') {
      steps {
        sh  'echo "Started smoke tests"'
        build job: 'smoke-test', parameters: [string(name: 'targetEnvironment', value: env.JOB_NAME)]
        // copyArtifacts(projectName: 'smoke-test', selector: specific("${build.number}"));
        sh 'echo "Finished smoke tests"'
      }
    }
    stage('Integration Test') {
      steps {
        sh  'echo "Started Integration tests"'
        //build job: 'integration-test', parameters: [string(name: 'targetEnvironment', value: env.JOB_NAME)]
        sh 'echo "Finished Integration tests"'
      }
    }
    stage('Copy artifacts') {
      steps {
        sh '''
          echo "Copy artifacts"
          sh scripts_pipelines/copy_artifacts/main.sh
        '''
      }
    }
    stage('Sync sources GM') {
      when {
        branch comparator: 'REGEXP', pattern: '^(master|ccu/.*|r.*)$'
      }
      steps {
        sh '''
          echo "Sync"
        '''
        //sh "./scripts/sync-sources-gm-ccu.sh"
      }
    }
    stage('Delivery to an artifactory') {
        steps {
      sh '''
        echo "Upload artifacts to the Artifactory"
      '''
    }
    }
  }
  post {
    success {
      archiveArtifacts 'deploy-sama5d27-wlsom1-ek/**/*.*'
      // MS Teams notification
      office365ConnectorSend (
        status: "Pipeline Succes",
        webhookUrl: "${TEAMS_WEB_HOOK}",
        color: '00ff00',
        message: "Build Successful: ${JOB_NAME} - (<${env.BUILD_URL}|${BUILD_DISPLAY_NAME}>)<br>Build duration time: ${currentBuild.durationString}"
      )
    }
    failure {
      // MS Teams notification
      office365ConnectorSend (
        status: "Pipeline Failure",
        webhookUrl: "${TEAMS_WEB_HOOK}",
        color: 'FF0000',
        message: "Build Failed: ${JOB_NAME} - (<${env.BUILD_URL}|${BUILD_DISPLAY_NAME}>)<br>Build duration time: ${currentBuild.durationString}"
      )
    }
    always {
      junit(
        allowEmptyResults: true,
        testResults: 'unit_tests/reports/*.xml'
      )
      sh '''
        echo "Finished"
      '''
    }
  }
}
