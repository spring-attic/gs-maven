pipeline {
	agent any

	tools {
		maven "maven"
	}

	environment{
	  ALPHA="develop"
      BETA="release"
      RC="master"	
	}

	stages {
		stage('download') {
			step{
			 git branch: 'develop', url: 'https://github.com/vinayramireddy/gs-maven.git'
			}
		}
		
		stage ('build'){
		   step{
		    sh 'mvn clean package'
		   }
		}
	}
	}
