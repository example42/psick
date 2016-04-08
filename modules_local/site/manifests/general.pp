# General baseline, common to all the nodes
#
class site::general {

  # include ::site::test

  ::tp::install3 { 'openssh': }

  # Sample sudo entry
  ::tp::conf3 { 'sudo::admin':
    content => "## admin ALL=NOPASSWD:ALL\n",
  }
  
  # Postfix as local mailer
  ::tp::install3 { 'postfix': }
  ::tp::conf3 { 'postfix':
    template     => hiera('tp::postfix::template', undef),
    options_hash => hiera('tp::postfix::options', { } ),
  }


}
