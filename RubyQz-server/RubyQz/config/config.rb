#===============================
# RubyQz config read
#

require 'YAML'
require File.dirname(__FILE__)+'/../support/nil'

module RubyQz
  
  class ConfigException < Exception
  end
  
  
  class Config
    def self.load file=nil
      begin
        yaml_file = YAML.load_file(file.nil? ? 'config.yml' : file)
      rescue Exception => e
        throw e
      end

      # rubyqz = yaml_file['RubyQz']
      # if rubyqz.nil?
      #   raise RubyQz::ConfigException.new 'Cannot find RubyQz section, it must be a root element'
      # end
    end
  end
end

# RubyQz::Config.new '/Users/benoit/dev/ruby/RubyQz/RubyQz-server/tests/config/fixtures/config2.yml'