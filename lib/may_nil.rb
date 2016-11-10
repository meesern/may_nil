#
# Usage: 
#   require 'may_nil'
#
# Examples:
#   may_nil{ nil.foo.bar[2].baz } => nil
#   may_nil{ 0.foo.bar[2].baz   } => Exception: NoMethodError
#

class NoMethodError
  def may_nil_missing_source
    if /undefined local variable or method/ !~ message
      $1 if /((::)?([A-Z]\w*)(::[A-Z]\w*)*)$/ =~ message
    end
  end
end

def may_nil &blk
  blk.call
rescue NoMethodError => e
  raise if e.may_nil_missing_source != "NilClass"
  nil 
end

