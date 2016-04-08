
$tp_installs=hiera('tp::install', {})
if $tp_installs != {} {
  create_resources('tp::install', $tp_installs)
}

$tp_confs=hiera('tp::conf', {})
if $tp_confs != {} {
  create_resources('tp::conf', $tp_confs)
}

$tp_dirs=hiera('tp::dir', {})
if $tp_dirs != {} {
  create_resources('tp::dir', $tp_dirs)
}

