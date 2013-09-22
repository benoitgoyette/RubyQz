module RubyQz
  module Listener
    class HTTP
      def initialize(config)
        @port = config['port']
        @bind_address = config['bind_address']
        print "instantiating HTTP listener on #{@bind_address} #{@port}\n"
      end
      def start
        print "HTTP listener start"
      end
    end
  end
end
