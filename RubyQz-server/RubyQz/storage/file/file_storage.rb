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
        timestamp = Time.now
        filename = timestamp.strftime('%24N')
        store_data topic, data, filename
        timestamp
      end

      def read(topic)
      end

private
      def create_topic topic
        Dir.mkdir @path+'/'+topic if(!Dir.exists?(@path+'/'+topic))
        @path+'/'+topic
      end

      def store_data topic, data, filename
        File.open(create_topic(topic)+'/'+filename, 'w+') do |file|
          file.write YAML.dump(data)
        end
      end
    end
  end
end
