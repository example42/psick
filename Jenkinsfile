pipeline {
  agent any
  stages {
    stage('Setup') {
      steps {
        sh "bin/jenkins_before.sh ${env.BRANCH_NAME}"
      }
    }
    stage('Syntax') {
      steps {
        sh 'bin/puppet_check_syntax_fast.sh all_but_chars'
        sh 'bin/puppet_lint.sh'
        sh 'bin/puppet_check_syntax_fast.sh chars'
      }
    }
    stage('Unit') {
      steps {
        sh 'bin/puppet_check_rake.sh site'
      }
    }
    stage('Diff') {
      steps {
        sh 'bin/puppet_ci.sh catalog_preview || true'
      }
    }
    stage('Integration') {
      steps {
        sh 'bin/puppet_check_beaker.sh || true'
      }
    }

    stage('Integration Rollout') {
      when {
        branch 'integration'
      }
      steps {
        stage('Deploy Puppet in test') {
          steps {
            sh 'bin/puppet_ci.sh r10k_deploy --env integration --ssh jenkins@puppet --sudo'
          }
        }
        stage('Run Puppet in test') {
          steps {
            sh 'bin/puppet_ci.sh task_run psick::puppet_agent --env integration'
          }
        }
        stage('Verify status in test') {
          steps {
            sh 'bin/puppet_ci.sh db_query --env integration'
          }
        }
      }
    }

    stage('Production Rollout') {
      when {
        branch 'production'
      }
      steps {
        stage('Merge accept to production') {
          steps {
            sh 'bin/gitlab_accept_merge_request.rb integration production'
          }
        }
        stage('Deploy Puppet in production') {
          steps {
            sh 'bin/puppet_ci.sh r10k_deploy --env production --ssh jenkins@puppet --sudo'
          }
        }
        stage('Run Puppet in production') {
          steps {
            sh 'bin/puppet_ci.sh task_run psick::puppet_agent --env production'
          }
        }
        stage('Verify status in production') {
          steps {
            sh 'bin/puppet_ci.sh db_query --env production'
          }
        }
      }
    }
  }
}
