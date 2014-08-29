#===============================
# RubyQz config read
#

require 'YAML'
require File.dirname(__FILE__)+'/../support/nil'
require File.dirname(__FILE__)+'/../exceptions/exceptions'

module RubyQz
  class Config

    def self.listener
      @@listener
    end
    def self.listener=(ref)
      @@listener=ref
    end

    def self.storage
      @@storage
    end
    def self.storage=(ref)
      @@storage=ref
    end

    def self.load file=nil
      begin
        yaml_file = YAML.load_file(file.nil? ? 'config.yml' : file)

        raise RubyQz::ConfigException.new "missing listener configuration in #{file}" if yaml_file['listener'].empty?
        raise RubyQz::ConfigException.new "missing listener scheme configuration in #{file}" if yaml_file['listener']['scheme'].empty?
        raise RubyQz::ConfigException.new "missing storage configuration in #{file}" if yaml_file['storage'].empty?
        raise RubyQz::ConfigException.new "missing storage scheme configuration in #{file}" if yaml_file['storage']['scheme'].empty?

        @@listener = RubyQz::Scheme.new yaml_file['listener']['scheme'], yaml_file['listener'][yaml_file['listener']['scheme']]
        @@storage = RubyQz::Scheme.new yaml_file['storage']['scheme'],  yaml_file['storage'][yaml_file['storage']['scheme']]
        [@@listener, @@storage]
      rescue Exception => e
        raise RubyQz::ConfigException.new e
      end
    end
  end

  class Scheme
    attr_accessor :scheme
    attr_accessor :params
    def initialize(scheme, params)
      @scheme = scheme
      @params = params
      params.each do |k,v|
        eval <<-ATTR
          @#{k} = "#{v}"
        ATTR
        eval(<<-FCT)
          def #{k}
            "#{v}"
          end
        FCT
      end
    end
  end
end
