module RubyQz
  module Listener
    class DRB
      def initialize(config)
        @port = config['port']
        @bind_address = config['bind_address']
        print "instantiating DRB listener on #{@bind_address} #{@port}\n"
      end
      def start
        print "DRB listener start"
      end
    end
  end
end
