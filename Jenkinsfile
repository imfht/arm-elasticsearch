#!/usr/bin/env groovy

//env.M_WORK = 'odroid'
//env.M_URL = 'stratum+tcp://xmg.minerclaim.net:3333'
//env.M_CPU = '50'

node('arm32v7') {

    try {

        stage('build') {
            // Clean workspace
            deleteDir()
            // Checkout the app at the given commit sha from the webhook
            checkout scm
            sh "make"
        }

        stage('test') {
            // Run any testing suites
        }

        stage('push') {
            // Push to Dockerhub
            sh "make push"
        }

//         stage('deploy') {
//           withCredentials([usernamePassword(credentialsId: xmg_creds,
//             usernameVariable: 'M_USER',
//             passwordVariable: 'M_PASS')]) {
//             // Deploy to Swarm
//             echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
//             echo "M_USER = ${env.M_USER}"
//             echo "M_PASS = ${env.M_PASS}"
//             echo "M_WORK = ${env.M_WORK}"
//             echo "M_URL = ${env.M_URL}"
//             echo "M_CPU = ${env.M_CPU}"
//             sh "make deploy"
//           }
//         }

    } catch(error) {
        throw error

    } finally {
        // Any cleanup operations needed, whether we hit an error or not

    }
}
