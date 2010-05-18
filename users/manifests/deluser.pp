define deluser {

    user {
        "$name":
            ensure   => absent,
       }
}

