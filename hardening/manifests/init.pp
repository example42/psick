# General Class for hardening 
# - Soft mode removes unnecessary services
# - Harder mode tries to follow eal4 guidelines
# Invent and customize your modes
# 
# Remove from here services used in other classes


class hardening {

    # Soft hardening 
    include "hardening::services" 

    # Harder hardening (EAL4 oriented)
    include "hardening::eal4" 

}

