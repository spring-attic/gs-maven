pipeline {
	agent any

	tools {
		maven 'maventest'
	}

	environment{
	  ALPHA="develop"
      BETA="release"
      RC="master"	
	}

	stages {
		stage('download') {
			steps{
			 git branch: 'develop', url: 'https://github.com/vinayramireddy/gs-maven.git'
			}
		}
		
		stage ('build'){
		   steps{
		    sh 'mvn clean package'
		   }
		}
	}
	}
