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
    assert_raises(RubyQz::ConfigException) do
      RubyQz::Config.load File.dirname(__FILE__)+'/fixtures/missing_file.yml'
    end

    begin
      RubyQz::Config.load File.dirname(__FILE__)+'/fixtures/missing_file.yml'
    rescue Exception=>e
      assert_equal true, e.message.include?("No such file or directory")
    end
  end

  def test_missing_listener_config
    assert_raises(RubyQz::ConfigException) do
      RubyQz::Config.load File.dirname(__FILE__)+'/fixtures/config_no_listener.yml'
    end

    begin
      RubyQz::Config.load File.dirname(__FILE__)+'/fixtures/config_no_listener.yml'
    rescue Exception=>e
      assert_equal true, e.message.include?("missing listener configuration")
    end
  end

  def test_missing_storage_config
    assert_raises(RubyQz::ConfigException) do
      RubyQz::Config.load File.dirname(__FILE__)+'/fixtures/config_no_storage.yml'
    end

    begin
      RubyQz::Config.load File.dirname(__FILE__)+'/fixtures/config_no_storage.yml'
    rescue Exception=>e
      assert_equal true, e.message.include?("missing storage configuration")
    end
  end

  def test_missing_listener_scheme_config
    assert_raises(RubyQz::ConfigException) do
      RubyQz::Config.load File.dirname(__FILE__)+'/fixtures/config_no_listener_scheme.yml'
    end

    begin
      RubyQz::Config.load File.dirname(__FILE__)+'/fixtures/config_no_listener_scheme.yml'
    rescue Exception=>e
      assert_equal true, e.message.include?("missing listener scheme configuration")
    end
  end

  def test_missing_storage_scheme_config
    assert_raises(RubyQz::ConfigException) do
      RubyQz::Config.load File.dirname(__FILE__)+'/fixtures/config_no_storage_scheme.yml'
    end

    begin
      RubyQz::Config.load File.dirname(__FILE__)+'/fixtures/config_no_storage_scheme.yml'
    rescue Exception=>e
      assert_equal true, e.message.include?("missing storage scheme configuration")
    end
  end


end