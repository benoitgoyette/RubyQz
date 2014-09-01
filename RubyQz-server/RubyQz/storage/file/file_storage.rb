require 'FileUtils'
require File.dirname(__FILE__)+'/../../exceptions/exceptions'
\
module RubyQz
  module Storage
    class FileStorage
      attr_accessor :path

      def initialize(scheme)
        @path = scheme.path
        raise RubyQz::FileException.new("folder #{@path} does not exist or is not writable") if !Dir.exists?(@path) || !File.writable?(@path)
      end

      def store(topic, data)
        return Time.now.to_i

      end

      def read(topic)
      end
    end
  end
end
