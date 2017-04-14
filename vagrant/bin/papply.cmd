set base_dir="C:\vagrant_puppet"
set manifest="C:\vagrant_puppet\manifests\site.pp"

puppet apply -t --environmentpath "C:\" --environment "vagrant_puppet" --detailed-exitcodes %manifest%


