(Dir["#{File.dirname(__FILE__)}/**/*.rb"]-[File.join(File.dirname(__FILE__), __FILE__)]).each { |f| require f }

module RubyQz
  module Storage
    module Factory
      def self.instantiate(config)
        scheme = config['scheme']
        Object::const_get('RubyQz::Storage::'+scheme).new(config[scheme])
      end
    end
  end
end

