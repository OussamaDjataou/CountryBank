pipeline {
    agent any
    tools {
        jdk 'jdk17'
    }
    environment {
        SCANNER_HOME= tool 'sonar-scanner'
    }

    stages {
        
        stage('OWASP Dependency Check') {
            steps {
                 dependencyCheck additionalArguments: ' --scan ./ ', odcInstallation: 'DC'
                    dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        
        stage('Trivy') {
            steps {
                 sh "trivy fs ."
            }
        }

        stage('Build'){
            steps {
                dir("/var/lib/jenkins/workspace/pipeline2/src/main/java/com/cbank"){
                    sh '''javac  CountryBankApplication.java
                    java CountryBankApplication
                    '''
                }
            }
        }
        stage('SONARQUBE ANALYSIS') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh " $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=CountryBank -Dsonar.projectKey=CountryBank "
                }
            }
        }
        
         stage('Build & deploy') {
            steps {
                 sh "docker-compose up -d"
            }
        }
    }
}
