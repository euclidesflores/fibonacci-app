pipeline {
    agent any
    environment {
      AWS_DEFAULT_REGION = 'us-east-2'
      AWS_REGION = 'us-east-2'
      CREDENTIALS = credentials('fibonacci')
    }

    stages {
        stage('Clean WS') {
            steps {
                cleanWs()
            }
        }
        stage('Clone repository') {
            steps {
                git 'https://github.com/euclidesflores/fibonacci-app.git'
            }
        }

        stage('CodeBuild') {
            options {
                timeout(time: 5, unit: 'MINUTES')
            }
            steps {
                awsCodeBuild credentialsType: 'keys',
                    artifactLocationOverride: 'fibonacci-dominant-marlin',
                    artifactPackagingOverride: 'ZIP',
                    artifactTypeOverride: 'S3',
                    buildTimeoutOverride: '6',
                    computeTypeOverride: 'BUILD_GENERAL1_SMALL',
                    downloadArtifacts: 'true',
                    environmentTypeOverride: 'LINUX_CONTAINER',
                    overrideArtifactName: 'True',
                    projectName: 'fibonacci-project',
                    region: "$AWS_REGION",
                    sourceControlType: 'jenkins',
                    sourceLocationOverride: 'fibonacci-dominant-marlin/codebuild-artifact.zip',
                    sourceTypeOverride: 'S3'
            }
        }
    }

    post {
        always {
            sh 'rm -rf -- ..?* .[!.]* *'
        }
}