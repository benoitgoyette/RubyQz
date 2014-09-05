require 'test/unit'
require File.dirname(File.absolute_path(__FILE__)) + '/../../RubyQz/config/config.rb'

class TestConfig < Test::Unit::TestCase
  
  def test_class_exists
    assert_not_nil  RubyQz::Config.new
  end

  def test_load_file
    y = RubyQz::Config.load File.dirname(__FILE__)+'/fixtures/config1.yml'
    assert_not_nil y
  end

  def test_listener_params
    y = RubyQz::Config.load File.dirname(__FILE__)+'/fixtures/config1.yml'
    assert_equal 'DRB', RubyQz::Config::listener.scheme
    assert_equal '1234', RubyQz::Config::listener.port
    assert_equal 'localhost', RubyQz::Config::listener.bind_address
    assert_equal({'bind_address'=>'localhost', 'port'=>1234}, RubyQz::Config::listener.params)
  end

  def test_storage_params
    y = RubyQz::Config.load File.dirname(__FILE__)+'/fixtures/config1.yml'
    assert_equal 'file', RubyQz::Config::storage.scheme
    assert_equal '/tmp/filestorage', RubyQz::Config::storage.path
    assert_equal({'path'=>'/tmp/filestorage'}, RubyQz::Config::storage.params)
  end

  def test_missing_file
    filename = File.dirname(__FILE__)+'/fixtures/missing_file.yml'
    assert_raise_with_message(RubyQz::ConfigException, "No such file or directory #{filename}") do
      RubyQz::Config.load filename
    end
  end

  def test_missing_listener_config
    filename = File.dirname(__FILE__)+'/fixtures/config_no_listener.yml'
    assert_raise_with_message(RubyQz::ConfigException, "missing listener configuration in #{filename}") do
      RubyQz::Config.load filename
    end
  end

  def test_missing_storage_config
    filename = File.dirname(__FILE__)+'/fixtures/config_no_storage.yml'
    assert_raise_with_message(RubyQz::ConfigException, "missing storage configuration in #{filename}") do
      RubyQz::Config.load filename
    end
  end

  def test_missing_listener_scheme_config
    filename = File.dirname(__FILE__)+'/fixtures/config_no_listener_scheme.yml'
    assert_raise_with_message(RubyQz::ConfigException, "missing listener scheme configuration in #{filename}") do
      RubyQz::Config.load filename
    end
  end

  def test_missing_storage_scheme_config
    filename = File.dirname(__FILE__)+'/fixtures/config_no_storage_scheme.yml'
    assert_raise_with_message(RubyQz::ConfigException, "missing storage scheme configuration in #{filename}") do
      RubyQz::Config.load filename
    end
  end

  def test_missing_DRB_scheme_config
    filename = File.dirname(__FILE__)+'/fixtures/config_no_DRB_listener.yml'
    assert_raise_with_message(RubyQz::ConfigException, "missing listener scheme configuration DRB in #{filename}") do
      RubyQz::Config.load filename
    end
  end

  def test_missing_file_scheme_config
    filename = File.dirname(__FILE__)+'/fixtures/config_no_file_storage.yml'
    assert_raise_with_message(RubyQz::ConfigException, "missing storage scheme configuration 'file' in #{filename}") do
      RubyQz::Config.load filename
    end
  end

end