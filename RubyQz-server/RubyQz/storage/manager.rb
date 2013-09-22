module RubyQz
  module Storage
    class StorageManager
      def initialize(listener)
        print "initializing manager\n"
        start_listener listener
      end
    end
  end
end