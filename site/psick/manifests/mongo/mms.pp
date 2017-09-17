#
class psick::mongo::mms (
  String                 $ensure                    = $::psick::mongo::ensure,

  String                 $apikey                    = '',
  String                 $baseurl                   = '',

  Boolean                $monitoring_agent_install  = true,
  String                 $monitoring_agent_template = 'psick/mongo/mms/monitoring-agent.config.erb',

  Boolean                $backup_agent_install      = true,
  String                 $backup_agent_template     = 'psick/mongo/mms/backup-agent.config.erb',

  Boolean                $automation_agent_install  = true,
  String                 $automation_agent_template = 'psick/mongo/mms/automation-agent.config.erb',

  Boolean                $master_install            = false,
  String                 $master_template           = '',
) {

  # Options hash is shared across all the single packages setups
  $options=hiera_hash('psick::mongo::mms::options', { })
  $options_default = {
    'mmsApiKey'      => $apikey,
    'mmsBaseUrl'     => $baseurl,
    'maxLogFiles'    => '10',
    'maxLogFileSize' => '268435456',
    'httpProxy'      => '',
    'mothership'     => '',
    'backup_https'   => false,
  }
  $all_options = $options_default + $options


  # monitoring_agent setup
  if $monitoring_agent_install {
    $monitoring_agent_user_settings=hiera_hash('psick::mongo::mms::monitoring_agent_settings', { })
    $monitoring_agent_tp_settings = tp_lookup('mongodb-mms-monitoring-agent','settings','tinydata','merge')
    $monitoring_agent_settings = $monitoring_agent_tp_settings + $monitoring_agent_user_settings

    ::tp::install { 'mongodb-mms-monitoring-agent':
      auto_repo     => false,
      settings_hash => $monitoring_agent_settings,
    }

    if $monitoring_agent_template != '' {
      ::tp::conf { 'mongodb-mms-monitoring-agent':
        template      => $monitoring_agent_template,
        options_hash  => $options,
        settings_hash => $monitoring_agent_settings,
      }
    }
  }

  # backup_agent setup
  if $backup_agent_install {
    $backup_agent_user_settings=hiera_hash('psick::mongo::mms::backup_agent_settings', { })
    $backup_agent_tp_settings = tp_lookup('mongodb-mms-backup-agent','settings','tinydata','merge')
    $backup_agent_settings = $backup_agent_tp_settings + $backup_agent_user_settings

    ::tp::install { 'mongodb-mms-backup-agent':
      auto_repo     => false,
      settings_hash => $backup_agent_settings,
    }

    if $backup_agent_template != '' {
      ::tp::conf { 'mongodb-mms-backup-agent':
        template      => $backup_agent_template,
        options_hash  => $options,
        settings_hash => $backup_agent_settings,
      }
    }
  }

  # automation_agent setup
  if $automation_agent_install {
    $automation_agent_user_settings=hiera_hash('psick::mongo::mms::automation_agent_settings', { })
    $automation_agent_tp_settings = tp_lookup('mongodb-mms-automation-agent','settings','tinydata','merge')
    $automation_agent_settings = $automation_agent_tp_settings + $automation_agent_user_settings

    ::tp::install { 'mongodb-mms-automation-agent':
      auto_repo     => false,
      settings_hash => $automation_agent_settings,
    }

    if $automation_agent_template != '' {
      ::tp::conf { 'mongodb-mms-automation-agent':
        template      => $automation_agent_template,
        options_hash  => $options,
        settings_hash => $automation_agent_settings,
      }
    }
  }

  # master setup
  if $master_install {
    $master_user_settings=hiera_hash('psick::mongo::mms::master_settings', { })
    $master_tp_settings = tp_lookup('mongodb-mms','settings','tinydata','merge')
    $master_settings = $master_tp_settings + $master_user_settings

    ::tp::install { 'mongodb-mms':
      auto_repo     => false,
      settings_hash => $master_settings,
    }

    if $master_template != '' {
      ::tp::conf { 'mongodb-mms':
        template      => $master_template,
        options_hash  => $options,
        settings_hash => $master_settings,
      }
    }
  }

}
