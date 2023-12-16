pipeline {
    agent any
    tools {
        jdk 'jdk17'
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
        
         stage('Build & deploy') {
            steps {
                 sh "docker-compose up -d"
            }
        }
    }
}
