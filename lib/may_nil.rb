#
# Usage: 
#   require 'may_nil'
#
# Examples:
#   may_nil{ nil.foo.bar[2].baz } => nil
#   may_nil{ 0.foo.bar[2].baz   } => Exception: NoMethodError
#

def may_nil &blk
  blk.call
rescue NoMethodError => e
  raise if e.missing_name != "NilClass"
  nil 
end

