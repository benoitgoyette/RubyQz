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
    @topic = 'test'
    Dir.mkdir folder if !Dir.exists? folder
    FileUtils.chmod 0777, folder
    FileUtils.rm_rf folder+'/'+@topic
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
    start = Time.now
    file_storage = RubyQz::Storage::FileStorage.new @file_config
    timestamp = file_storage.store @topic, @data
    sleep 1
    endTime = Time.now
    assert timestamp > start, "file timestamp invalid 1"
    assert timestamp < endTime, "file timestamp invalid 1"

    assert Dir.exists?(file_storage.path + '/test')

    filename = timestamp.strftime('%24N')
    assert (File.exists? file_storage.path+'/'+@topic+'/'+filename), "file does not exist"

    unmarshalled = nil
    File.open(file_storage.path+'/'+@topic+'/'+filename, "r") do |file|
      content = file.read
      unmarshalled = YAML.load content
    end
    assert_not_same @data, unmarshalled, "reference hash and unmarshalled hash are not identical"
  end

  def test_post_class
    custom = CustomClass.new('aaa', ["bb'b", 'ccc'])
    file_storage = RubyQz::Storage::FileStorage.new @file_config
    timestamp = file_storage.store @topic, custom
    filename = timestamp.strftime('%24N')
    unmarshalled = nil
    File.open(file_storage.path+'/'+@topic+'/'+filename, "r") do |file|
      content = file.read
      unmarshalled = YAML.load content
    end
    assert_not_same custom, unmarshalled, "custom class not same as unmarshalled class"
  end

  # def test_get_file
  #   start = Time.now.to_i
  #   file_storage = RubyQz::Storage::File.new @file_config
  #   data = file_storage.read 'test'
  #   assert_equal @data, data
  # end


end


class CustomClass
  attr_accessor :field_a
  attr_accessor :field_b
  def initialize a, b
    @field_a = a
    @field_b = b
  end
end
