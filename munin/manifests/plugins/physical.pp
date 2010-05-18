class munin::plugins::physical inherits munin::plugins::base {
    case $kernel {
    linux: { munin::plugin { iostat: } }
    }
}
