FROM example42/ubuntu-1404

RUN puppet apply --verbose --report --show_diff --pluginsync --summarize --modulepath "/docker/site:/docker/modules:/etc/puppet/modules" --hiera_config=/docker/hiera.yaml --detailed-exitcodes --manifestdir /docker/manifests/


