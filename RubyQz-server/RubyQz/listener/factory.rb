(Dir["#{File.dirname(__FILE__)}/**/*.rb"]-[File.join(File.dirname(__FILE__), __FILE__)]).each { |f| require f }

module RubyQz
  module Listener
    module Factory
      def self.instantiate(config)
        scheme = config['scheme']
        print "instantiating listener #{scheme}\n"
        Object::const_get('RubyQz::Listener::'+scheme).new(config[scheme])
      end
    end
  end
end

