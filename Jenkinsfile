pipeline {
  agent any
  stages {
    stage('Syntax') {
      parallel {
        stage('Syntax') {
          steps {
            sh '''bin/puppet_check_syntax_fast.sh all_but_chars


'''
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