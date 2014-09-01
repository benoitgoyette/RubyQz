require 'test/unit'
require File.dirname(File.absolute_path(__FILE__)) + '/../../../RubyQz/storage/File/file_storage.rb'

class TestFileStorage < Test::Unit::TestCase
  def TestFileClassExists
    assert_not_nil RubyQz::Storage::file.new
  end
end

