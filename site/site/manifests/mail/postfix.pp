class site::mail::postfix {

  ::tp::install3 { 'postfix': }
  ::tp::conf3 { 'postfix':
    template     => $template,
    options_hash => $options,
  }

}
