## Changelog

* Your contribution here.

* Added .editorconfig [@alvagante](https://github.com/alvagante)
* Removed skeleton dir, used pdk to create new modules [@alvagante](https://github.com/alvagante)

## Release 0.9.3 - Started modularisation
* [#247] Moved hieradata to separated module [@alvagante](https://github.com/alvagante)
* Vagrant foss environment [@AlessandroLorenzi](https://github.com/AlessandroLorenzi)
* Jenkinsfile and Jenkins integrations [@alvagante](https://github.com/alvagante)
* [#220](https://github.com/example42/psick/pull/220): Run acceptance tests also for newer puppet versions - [@tuxmea](https://github.com/tuxmea).

## Release 0.9.2 - Second alpha for version 1.0.0
* Updated docs to reflect new separated psick module layout [@alvagante](https://github.com/alvagante)
* Several fixes to data and samples [@alvagante](https://github.com/alvagante)

## Release 0.9.1 - First alpha for version 1.0.0. Not compatible with 0.3.0
* FOSS setup [@tuxmea](https://github.com/tuxmea)
* Data and site.pp refactored to use psick namespace [@alvagante](https://github.com/alvagante)
* Removed default site profile and tools. Added separated psick module [@alvagante](https://github.com/alvagante)
* Added firstrun mode [@alvagante](https://github.com/alvagante)

## Release 0.3.0

* Added links to lab services [@alvagante](https://github.com/alvagante)
* Working Sensu integration [@alvagante](https://github.com/alvagante)
* New tp profiles generated via pdk [@alvagante](https://github.com/alvagante)
* Design consolidation of profile::settings and profile::monitor entrypoints [@alvagante](https://github.com/alvagante)
* Refactoring of profile::pre [@alvagante](https://github.com/alvagante)
* Base profile classes refactored to do not use data in modules [@alvagante](https://github.com/alvagante)
### CHANGED
* Param enable renamed to manage on profile::base and profile::pre

## Release 0.2.0

* Started PDK integration - [@alvagante](https://github.com/alvagante)
* Started Danger integration - [@alvagante](https://github.com/alvagante)
* Control repo spec tests - [@tuxmea](https://github.com/tuxmea)
* Control repo integration tests - [@tuxmea](https://github.com/tuxmea)
* Initial Sensu integration - [@alvagante](https://github.com/alvagante)
* Automatic docs generation - [@alvagante](https://github.com/alvagante)
* Codacy cleaups - [@tuxmea](https://github.com/tuxmea), [@alvagante](https://github.com/alvagante)
* Added sample ec2_userdata scripts - [@alvagante](https://github.com/alvagante)

## Release 0.1.3

* Wider Windows support - [@alvagante](https://github.com/alvagante)
* Enhanced documentation - [@alvagante](https://github.com/alvagante)
* Oracle profiles - [@alvagante](https://github.com/alvagante)

## Release 0.1.2

* Added profile::proxy - [@alvagante](https://github.com/alvagante)
* Started conversion to data in modules in profile classes - [@alvagante](https://github.com/alvagante)
* Improved CI scripts - [@alvagante](https://github.com/alvagante)
* Reorganised general class load ordering in manifests/site.pp - [@alvagante](https://github.com/alvagante)

## Release 0.1.1

* Added critical missing lib files, not synced in initial mirror from control-repo - [@alvagante](https://github.com/alvagante)
* Smaller fixes in docs and scripts - [@alvagante](https://github.com/alvagante)

## Release 0.1.0

* First PSICK release is based on existing and consolidated example42 Puppet control-repo - [@alvagante](https://github.com/alvagante)
