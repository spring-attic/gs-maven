pipeline {
	agent any

	// triggers {
	// 	pollSCM 'H/10 * * * *'
	// }

	// options {
	// 	disableConcurrentBuilds()
	// 	buildDiscarder(logRotator(numToKeepStr: '14'))
	// }

	stages {

                stage("Build"){

                 steps {
                   sh 'mvn clean install -f complete/pom.xml'

                   }
                  }
		stage("test: baseline (jdk8)") {

			steps {
				sh 'test/run.sh'
			}
		}

	}

	post {
		changed {
			script {
				// slackSend(
				// 		color: (currentBuild.currentResult == 'SUCCESS') ? 'good' : 'danger',
				// 		channel: '#sagan-content',
				// 		message: "${currentBuild.fullDisplayName} - `${currentBuild.currentResult}`\n${env.BUILD_URL}")
				emailext(
						subject: "[${currentBuild.fullDisplayName}] ${currentBuild.currentResult}",
						mimeType: 'text/html',
						recipientProviders: [[$class: 'CulpritsRecipientProvider'], [$class: 'RequesterRecipientProvider']],
						body: "<a href=\"${env.BUILD_URL}\">${currentBuild.fullDisplayName} is reported as ${currentBuild.currentResult}</a>")
			}
		}
	}
}
