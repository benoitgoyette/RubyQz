require 'test/unit'
require File.dirname(File.absolute_path(__FILE__)) + '/../../RubyQz/config/config.rb'

class TestScheme < Test::Unit::TestCase

  def test_class_exists
    assert_not_nil RubyQz::Scheme.new 'file', {'path' => '/tmp/filestorage'}
  end

  def test_class_attributes
    file_scheme = RubyQz::Scheme.new 'file', {'path' => '/tmp/filestorage'}
    assert_equal 'file', file_scheme.scheme
    assert_equal '/tmp/filestorage', file_scheme.path
    assert_equal({'path' => '/tmp/filestorage'}, file_scheme.params)
  end

end