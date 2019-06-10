class profile::android (
        String $android_sdk_archive,
        String $android_home,
  Array[String] $android_sdk_tools,
)
{
  archive { "/tmp/${android_sdk_archive}":
    source       => "https://dl.google.com/android/repository/${android_sdk_archive}",
    extract      => true,
    extract_path => $android_home,
    user         => 'ubuntu',
    group        => 'ubuntu',
    }
  file_line { 'ANDROID_HOME':
    ensure => present,
    line   => "ANDROID_HOME=${android_home}",
    path   => '/etc/environment',
    }
  $android_sdk_tools.each |String $sdk_tool| {
    $sdk_tool_path = regsubst($sdk_tool, ';', '/')
    exec { "yes | ${android_home}/tools/bin/sdkmanager --install \"${sdk_tool}\"":
      creates => "${android_home}/${sdk_tool_path}",
    }
  }
}
