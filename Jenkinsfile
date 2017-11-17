pipeline {
  agent any
  stages {
    stage('Syntax') {
      parallel {
        stage('Syntax') {
          steps {
            echo 'Syntax check'
          }
        }
        stage('Lint') {
          steps {
            echo 'Lint'
          }
        }
        stage('Chars') {
          steps {
            echo 'Chars'
          }
        }
      }
    }
  }
}