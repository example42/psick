class hardening::eal4 {

    # This class tries to setup a system following Common Criteria EAL4+ guidelines
    # Note that an EAL4+ system involves much more than what is applied here
    # Starting configurations are made for RedHat/Centos 5 
    # Cross-distro support will be included when necessary

    # Services hardening
    include "hardening::services"

    # Administrative users
    include users::admins

    # Default account settings
    include hardening::logindefs    

    # Disable network root access and other SSH hardenings
    include ssh::eal4

    # Pam settings
    include pam::eal4

    # Remove unnecessary packages 
    include hardening::packages

    # Boot load configuration
    # include grub::eal4

    # Auditing configuration
    include audit 

    # Selinux (enforcement is REQUIRED for RBAC mode and OPTIONAL in CAPP mode)
    # include selinux::enforcing
    
}
