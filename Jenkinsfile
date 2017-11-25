pipeline {
  agent any
  stages {
    stage('Syntax') {
      parallel {
        stage('Syntax') {
          steps {
            sh 'bin/jenkins_before.sh'
            sh 'bin/puppet_check_syntax_fast.sh all_but_chars'
          }
        }
        stage('Chars') {
          agent any
          steps {
            sh 'bin/jenkins_before.sh'
            sh 'bin/puppet_check_syntax_fast.sh chars'
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
