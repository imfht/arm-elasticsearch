#!/usr/bin/env groovy

// def labels = ['armv7l', 'aarch64', 'x86_64'] // labels for Jenkins node types we will build on
def labels = ['armv7l', 'x86_64'] // labels for Jenkins node types we will build on
def builders = [:]
for (x in labels) {
  def label = x // Need to bind the label variable before the closure - can't do 'for (label in labels)'

  // Create a map to pass in to the 'parallel' step so we can fire all the builds at once
  builders[label] = {
    node(label) {
      try {

        stage('build') {
          deleteDir()
          checkout scm
          sh "make"
        }

        stage('test') {
        }

        stage('push') {
          sh "make push"
        }

      } catch(error) {
        throw error

      } finally {
        deleteDir()
      }
    }
  }
}

parallel builders

node('ansible') {

  try {

    stage('scm') {
      deleteDir()
      checkout scm
    }

    stage('provision') {
      // Ansible
      echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
      ansiColor('xterm') {
        ansiblePlaybook(
          playbook: 'playbook.yml',
          inventory: 'inventory.ini',
          colorized: true)
      }
    }

  } catch(error) {
    throw error

  } finally {
    deleteDir()
  }
}

node('manager') {

  try {

    stage('scm') {
      deleteDir()
      checkout scm
    }

    stage('deploy') {
      sh "make deploy"
    }

  } catch(error) {
    throw error

  } finally {
    deleteDir()
  }
}
