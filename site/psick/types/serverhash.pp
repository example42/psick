type Profile::Serverhash = Struct[{

  Optional[scheme] => String,
  Optional[host] => String,
  Optional[port] => Variant[Integer, String],
  Optional[user] => String,
  Optional[password] => String,
  Optional[path] => String,
  Optional[query] => String,
  Optional[fragment] => String,

  # proxy_server specific
  Optional[no_proxy] => Array,

}]
