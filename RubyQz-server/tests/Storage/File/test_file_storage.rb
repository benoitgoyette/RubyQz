require 'test/unit'
require 'YAML'
require 'FileUtils'
require File.dirname(File.absolute_path(__FILE__)) + '/../../../RubyQz/storage/file/file_storage.rb'
require File.dirname(File.absolute_path(__FILE__)) + '/../../../RubyQz/config/config.rb'

class TestFileStorage < Test::Unit::TestCase

  attr_accessor :file_config
  attr_accessor :data

  # TODO: file folder does not exist
  # TODO: file write
  # TODO: file read

  def setup
    folder = '/tmp/filestorage'
    @file_config = RubyQz::Scheme.new 'file', {'path'=>folder}
    @data = {"some_key"=>{"other_key"=>"some_data"} }
    Dir.mkdir folder if !Dir.exists? folder
    FileUtils.chmod 0777, folder
  end

  def test_file_class_exists
    assert_not_nil RubyQz::Storage::FileStorage.new @file_config
  end

  def test_file_configured
    file_storage = RubyQz::Storage::FileStorage.new @file_config
    assert_equal '/tmp/filestorage', file_storage.path
  end

  def test_folder_not_exists
    @file_config = RubyQz::Scheme.new 'file', {'path'=>'/folder_does_not_exist'}
    assert_raises(RubyQz::FileException) do
      file_storage = RubyQz::Storage::FileStorage.new @file_config
    end
    begin
      file_storage = RubyQz::Storage::FileStorage.new @file_config
    rescue RubyQz::FileException => e
      assert_equal "folder /folder_does_not_exist does not exist or is not writable", e.message
    end
  end

  def test_folder_not_writable
    folder = File.dirname(__FILE__)+'/../fixtures/folder_not_writable'
    Dir.mkdir folder if !Dir.exists?(folder)
    FileUtils.chmod 0555, folder
    @file_config = RubyQz::Scheme.new 'file', {'path'=>folder}

    assert_raises(RubyQz::FileException) do
      file_storage = RubyQz::Storage::FileStorage.new @file_config
    end
    begin
      file_storage = RubyQz::Storage::FileStorage.new @file_config
    rescue RubyQz::FileException => e
      assert_equal "folder #{folder} does not exist or is not writable", e.message
    end
  end

  def test_post_file
    start = Time.now.to_i
    file_storage = RubyQz::Storage::FileStorage.new @file_config
    timestamp = file_storage.store 'test', @data
    sleep 1
    endTime = Time.now.to_i
    assert_not_nil timestamp > start
    assert_not_nil timestamp < endTime
  end

  # def test_get_file
  #   start = Time.now.to_i
  #   file_storage = RubyQz::Storage::File.new @file_config
  #   data = file_storage.read 'test'
  #   assert_equal @data, data
  # end


end

