# Set an external fact
define tools::puppet::set_external_fact (
  Any $value,
  Enum['absent','present'] $ensure = 'present',
) {

  $external_facts_dir = $::kernel ? {
    'Windows' => 'C:\ProgramData\PuppetLabs\facter\facts.d',
    default   => '/etc/puppetlabs/facter/facts.d',
  }

  if !defined(Tools::Create_dir[$external_facts_dir]) {
    tools::create_dir { $external_facts_dir:
      before => File["${external_facts_dir}/${title}.yaml"],
    }
  }

  file { "${external_facts_dir}/${title}.yaml":
    ensure  => $ensure,
    content => "---\n  ${title}: ${value}\n",
  }

}
