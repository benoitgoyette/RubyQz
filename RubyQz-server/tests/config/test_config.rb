require 'test/unit'
require File.dirname(File.absolute_path(__FILE__)) + '/../../RubyQz/config/config.rb'


class TestConfig < Test::Unit::TestCase
  
  def test_class_exists
    assert_not_nil  RubyQz::Config.new
  end
  
  def test_load_file
    y = RubyQz::Config.new File.dirname(__FILE__)+'/fixtures/config1.yml'
    assert_not_nil  y
  end

  def test_load_file
    assert_raises(RubyQz::ConfigException) do
      RubyQz::Config.new File.dirname(__FILE__)+'/fixtures/config2.yml'
    end
  end
  
end