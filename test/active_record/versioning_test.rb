# This test suite tests the actual versioning of versioned fields

require File.join( File.dirname(__FILE__), '..', 'test_helper' )
require 'active_record'

begin
  require 'globalize/model/active_record'
rescue MissingSourceFile
  puts "This plugin requires the Globalize2 plugin: http://github.com/joshmh/globalize2/tree/master"
  puts
  raise
end

require 'globalize2_versioning'

# Hook up model translation
ActiveRecord::Base.send :include, Globalize::Model::ActiveRecord::Translated
ActiveRecord::Base.send :include, Globalize::Model::ActiveRecord::Versioned

# Load Section model
require File.join( File.dirname(__FILE__), '..', 'data', 'post' )

class VersioningTest < ActiveSupport::TestCase
  def setup
    I18n.fallbacks.clear 
    reset_db!
  end
  
  test 'new record version' do
  end
  
  test 'save_version?' do
    section = Section.create :content => 'foo'
    assert !section.save_version?
    section.title = 'bar'
    assert !section.save_version?
    section.content = 'baz'
    assert !section.save_version?
  end

  test 'revert_to' do
    flunk
  end
  
  test 'revert_to!' do
    flunk
  end
  
  test 'versions association' do
    flunk
  end
  
  test 'save_version_on_create' do
    flunk
  end

  test 'clone_versioned_model' do
    flunk
  end
end