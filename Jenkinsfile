pipeline {
  agent any
  stages {
    stage('Syntax') {
      parallel {
        stage('Syntax') {
          steps {
            sh 'pdk validate'
          }
        }
        stage('Chars') {
          agent any
          steps {
            echo 'Chars'
          }
        }
      }
    }
    stage('Unit') {
      steps {
        sh 'pdk  test unit'
      }
    }
    stage('Diff') {
      steps {
        sh 'bin/gitlab_catalog_preview.sh'
      }
    }
    stage('Integration') {
      steps {
        echo 'Integration'
      }
    }
  }
}