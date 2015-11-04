
#
# Usage: 
#   require 'may_nil'
#
# Examples:
#   may_nil{ nil.foo.bar[2].baz } => nil
#   may_nil{ 0.foo.bar[2].baz   } => Exception: NoMethodError
#

def may_nil &blk
  call blk
rescue NoMethodError => e
  raise unless e.missing_name != "NilClass"
  nil 
end

