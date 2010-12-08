define link (
    $title,
    $description='',
    $url,
    $host,
    $priority='50',
    $type='admin',
    $private='no',
    $linktags='',
    $login='',
    $password='',
    $enable='true',
    $tool=''
    ) {

    if ($tool =~ /psick/) {
        link::psick { "$name":
            title       => $title,
            description => $description,
            url         => $url,
            host        => $host,
            priority    => $priority,
            type        => $type,
            private     => $private,
            linktags    => $linktags,
            login       => $login,
            password    => $password,
            enable      => $enable,
        }
    }

}
