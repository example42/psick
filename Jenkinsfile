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
        stage('Lint') {
          agent any
          steps {
            sh 'bin/jenkins_before.sh'
            sh 'bin/puppet_lint.sh'
          }
        }
      }
    }
    stage('Unit') {
      agent any
      steps {
        sh 'bin/jenkins_before.sh'
        sh 'bin/puppet_check_rake.sh site'
      }
    }
    stage('Diff') {
      steps {
        sh 'bin/gitlab_catalog_preview.sh'
      }
    }
    stage('Integration') {
      steps {
        sh 'bin/jenkins_before.sh'
        sh 'bin/puppet_check_beaker.sh'
      }
    }
    stage('Rollout') {
      steps {
        sh 'bin/puppet_job_run.sh production'
        sh 'bin/puppetdb_env_query.sh production'
      }
    }
    stage('Documentation') {
      steps {
        sh 'rm -rf doc public .yardoc README.md'
        sh 'bin/docs_classlistgenerate.sh site/profile docs/classes.md'
        sh 'for f in $(cat docs/toc.txt); do cat docs/$f >> README.md ; echo >> README.md ; done'
        sh 'bin/jenkins_before.sh'
        sh 'puppet strings generate site/**/**/*{.pp\,.rb} site/**/**/**/*{.pp\,.rb} modules/psick/**/*{.pp\,.rb} modules/psick/**/**/*{.pp\,.rb} modules/psick/**/**/**/*{.pp\,.rb} manifests/site.pp'
      }
    }
  }
}
