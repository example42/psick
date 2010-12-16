# A search engine for Puppet based on MCollective Registration

These are puppet parser functions and utility scripts that use MCollective
registration system to build a searchable database from within manifests 
and templates.

Due to limitation with Puppets plugin system you need to install these in
your ruby site lib.

<pre>
   /usr/lib/ruby/site_ruby/1.8/puppet/util/mongoquery.rb
   /usr/lib/ruby/site_ruby/1.8/puppet/parser/function/load_node.rb
   /usr/lib/ruby/site_ruby/1.8/puppet/parser/function/search_nodes.rb
   /usr/lib/ruby/site_ruby/1.8/puppet/parser/function/search_setup.rb
</pre>

You should add to your site.pp the following - assuming you already have
the mongo registration setup and data flowing in there:

   search_setup("localhost", "puppet", "nodes")

You can now use the search_nodes and load_node functions to search 
and load nodes.

The load_nodes function require Puppet 2.6 hash support.

See http://srt.ly/3t for use cases.
