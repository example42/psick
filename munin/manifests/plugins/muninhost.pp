class munin::plugins::muninhost inherits munin::plugins::base {
    munin::plugin { munin_update: }
    munin::plugin { munin_graph: }
}
