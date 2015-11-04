# may_nil
Ruby method chaining without worrying about nils

## What?

`may_nil` allows us to write ruby method chains that succinctly handle nil anywhere in the chain.

## Examples

    require 'may_nil'

If we have some data...
 
     a = {person: {name: 'Bob', pet: { likes: ['cat', 'dog', 'mouse'], owns: 'dog' } } }
     may_nil {a[:person][:pet][:owns]}                                                      => 'dog'
     
     a = {person: {name: 'Bob', pet: { likes: ['cat', 'dog', 'mouse'] } } }
     may_nil {a[:person][:pet][:owns]}                                                      =>  nil
     
     a = {person: {name: 'Bob' } }
     may_nil {a[:person][:pet][:owns]}                                                      =>  nil
     
     a = nil
     may_nil {a[:person][:pet][:owns]}                                                      =>  nil

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
 
    gem 'may_nil'
    
## Why?

`may_nil` is similar in purpose to the `andand` gem (https://github.com/raganwald/andand) but removes the need
to fill the method chain with `.andand`...

    nil.andand.foo.bar            => Exception: NoMethodError (bar on NilClass)
    nil && nil.foo && nil.foo.bar => nil
    nil.andand.foo.andand.bar     => nil
    may_nil {nil.foo.bar}         => nil
   
   
