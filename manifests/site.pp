# This is the default manifest used in Vagrant and PuppetMaster
# environments.
#
# Here we have a $::role driven nodeless setup where
# we just include our site class where we include common and per role classes

include ::site

