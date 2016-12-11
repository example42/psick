#
class profile::ci::gitlab_runner (
  String                $ensure      = 'present',
  Boolean               $auto_prerequisites = true,
  Optional[String]      $template    = undef, # 'profile/ci/gitlab_runner/config.toml.erb',
  Hash                  $options     = { },
  Hash                  $runners     = { },
) {

  $options_default = {
  }
  $gitlab_runner_options = $options_default + $options
  ::tp::install { 'gitlab-runner' :
    ensure             => $ensure,
    auto_prerequisites => true,
  }

  if $template {
    ::tp::conf { 'gitlab-runner':
      ensure       => $ensure,
      template     => $template,
      options_hash => $gitlab_runner_options,
    }
  }

  if $runners != {} {
    $runners.each | $k , $v | {
      tools::gitlab_runner::runner { $k:
        * => $v,
      }
    }
  }
}

