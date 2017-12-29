pipeline {
  agent any
  stages {
    stage('Setup') {
      steps {
        sh "bin/jenkins_before.sh ${env.BRANCH_NAME}"
      }
    }
    stage('Syntax') {
      parallel {
        stage('Syntax') {
          steps {
            sh 'bin/puppet_check_syntax_fast.sh all_but_chars'
          }
        }
        stage('Chars') {
          steps {
            sh 'bin/puppet_check_syntax_fast.sh chars'
          }
        }
        stage('Lint') {
          steps {
            sh 'bin/puppet_lint.sh'
          }
        }
      }
    }
    stage('Unit') {
      steps {
        sh 'bin/puppet_check_rake.sh site'
      }
    }
    stage('Diff') {
      steps {
        sh 'bin/gitlab_catalog_preview.sh || true'
      }
    }
    stage('Integration') {
      steps {
        sh 'bin/puppet_check_beaker.sh'
      }
    }
    stage('Rollout') {
      steps {
        sh 'bin/puppet_job_run.sh production'
        sh 'bin/puppetdb_env_query.sh production'
      }
    }
  }
}
