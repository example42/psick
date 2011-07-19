class virtualbox::repo {
    case $operatingsystem {
        debian: { include apt::repo::virtualbox }
        ubuntu: { include apt::repo::virtualbox }
        centos: { include yum::repo::virtualbox }
        redhat: { include yum::repo::virtualbox }
    }
}
