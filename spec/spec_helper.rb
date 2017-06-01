require 'rubygems'
require 'puppetlabs_spec_helper/module_spec_helper'
# XXX: Doesn't work with facter 3
#require 'rspec-puppet-facts'
#include RspecPuppetFacts

# We need this because the RAL uses 'should' as a method.  This
# allows us the same behaviour but with a different method name.
#class Object
#    alias :must :should
#end
