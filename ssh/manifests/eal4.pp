class ssh::eal4 {

    # Cripto settings
    ssh::config { Protocol:
        value => "2",
    }

    ssh::config { Ciphers:
        value => "3des-cbc",
    }

    # X11 forwarding (You MAY allow)
    ssh::config { X11Forwarding:
        value => "no",
    }


    # Login settings
    ssh::config { UsePAM:
        value => "yes",
    }

    ssh::config { PermitRootLogin:
        value => "no",
    }

    ssh::config { PermitEmptyPasswords:
        value => "no",
    }

    ssh::config { PasswordAuthentication:
        value => "no",
    }

    ssh::config { ChallengeResponseAuthentication:
        value => "yes",
    }

    # Disables other authentication methods (you MAY want to change some of these settings)

    ssh::config { IgnoreRhosts:
        value => "yes",
    }

    ssh::config { HostbasedAuthentication:
        value => "no",
    }

    ssh::config { PubkeyAuthentication:
        value => "no",
    }

    ssh::config { RhostsRSAAuthentication:
        value => "no",
    }

    ssh::config { RSAAuthentication:
        value => "no",
    }

    ssh::config { KerberosAuthentication:
        value => "no",
    }

    ssh::config { GSSAPIAuthentication:
        value => "no",
    }

}
