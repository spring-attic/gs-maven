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
			dir('complete') {	   
		   	sh  'mvn clean package'
		   	}
		  }
		}
		
		
		
                stage ('deploy to qa'){
		when {anyOf {branch BETA;}
		}
		steps{
		      deploy adapters: [tomcat9(credentialsId: 'c9c0feb8-2347-4044-82d5-f22f0d96378d', 
		      path: '', url: 'http://172.31.32.73:7070')], contextPath: 'qaenv', war: '**/*.war'
		}
		}
	}
	}
