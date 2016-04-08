
$tp_installs=hiera('tp::install', {})
if $tp_installs != {} {
  create_resources('tp::install4', $tp_installs)
}

$tp_confs=hiera('tp::conf', {})
if $tp_confs != {} {
  create_resources('tp::conf4', $tp_confs)
}

$tp_dirs=hiera('tp::dir', {})
if $tp_dirs != {} {
  create_resources('tp::dir4', $tp_dirs)
}

