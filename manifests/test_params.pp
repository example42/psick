
$got = params_lookup('got','global')
notify { "We got ${got}": }
include test_params
