# may_nil
Ruby method chaining without worrying about nils

## What?

`may_nil` allows us to write ruby method chains that succinctly handle nil anywhere in the chain.

A typical use case is for exploring deeply nested structures such as parsed JSON objects.

## Examples

    require 'may_nil'

    nil.foo.bar[2].baz             => Exception: NoMethodError (foo on NilClass)
    may_nil {nil.foo.bar[2].baz}   => nil
    may_nil {100.foo.bar[2].baz}   => Exception: NoMethodError (foo on Fixnum)

## Installing

  
    
## Why?

This is similar in purpose to the `andand` gem (https://github.com/raganwald/andand) but removes the need
to fill the method chain with `.andand`

    nil.andand.foo                => nil
    may_nil {nil.foo}             => nil
    nil.andand.foo.bar            => Exception: NoMethodError (bar on NilClass)
    nil && nil.foo && nil.foo.bar => nil
    nil.andand.foo.andand.bar     => nil
    may_nil {nil.foo.bar}         => nil
   
   
