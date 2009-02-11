require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_support/test_case'
require File.expand_path( File.join( File.dirname(__FILE__), '..', '..', 
  'globalize2', 'test', 'test_helper' ) )

# globalize2_versioning lib
$LOAD_PATH << File.expand_path( File.dirname(__FILE__) + '/../lib' )