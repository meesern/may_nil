# may_nil
Ruby method chaining without worrying about nils

## What?

`may_nil` allows us to write ruby method chains that succinctly handle nil anywhere in the chain.  Within the block passed to `may_nil` any undefined method on the NilClass termiates the block returning nil.  All exceptions other than NoMethodError on NilClass are raised as usual. 

## Examples

    require 'may_nil'

If we have some data...

    a = {person: {name: 'Bob',  pet: { likes: ['cat', 'dog', 'mouse'], owns: 'dog' } } }
    b = {person: {name: 'Bill', pet: { likes: ['cat', 'dog', 'mouse'] } } }
    c = {person: {name: 'Brian' } }
    d = nil
    
    def owns_pet( data )
      may_nil {data[:person][:pet][:owns]}
    end
    
    owns_pet(a)   => 'dog'
    owns_pet(b)   =>  nil
    owns_pet(c)   =>  nil
    owns_pet(d)   =>  nil
    
Or a method chain...

    nil.foo.bar[2].baz             => Exception: NoMethodError (foo on NilClass)
    may_nil {nil.foo.bar[2].baz}   => nil
    may_nil {100.foo.bar[2].baz}   => Exception: NoMethodError (foo on Fixnum)

    class Fixnum
      def foo(v) 
        v+1
      end
      def bar(v)
        [v]
      end
      def baz(v)
        v.to_s
      end
    end
    may_nil {1.foo.bar[0].baz}    => "2"
    may_nil {1.foo.bar[1].baz}    => nil
    

## Installing

### Gemfile
 
    gem 'may_nil', :git => 'https://github.com/meesern/may_nil.git'

    
## Why?

`may_nil` is similar in purpose to the `andand` gem (https://github.com/raganwald/andand) but removes the need
to fill the method chain with `.andand`...

    nil.andand.foo.bar            => Exception: NoMethodError (bar on NilClass)
    nil && nil.foo && nil.foo.bar => nil
    nil.andand.foo.andand.bar     => nil
    may_nil {nil.foo.bar}         => nil
   
   
