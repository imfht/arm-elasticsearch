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

    } catch(error) {
        throw error

    } finally {
        // Any cleanup operations needed, whether we hit an error or not

    }
}

node('master') {

    try {

        stage('scm') {
            // Clean workspace
            deleteDir()
            // Checkout the app at the given commit sha from the webhook
            checkout scm
        }

        stage('deploy') {
            sh "make deploy"
        }

    } catch(error) {
        throw error

    } finally {
        // Any cleanup operations needed, whether we hit an error or not

    }
}
