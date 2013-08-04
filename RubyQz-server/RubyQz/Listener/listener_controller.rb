trap("SIGINT") { raise SignalException.new :INT }
trap("SIGKILL") { raise SignalException.new :KILL }
trap("SIGABRT") { raise SignalException.new :ABRT }
trap("SIGTERM") { raise SignalException.new :TERM }

module RubyQz
  module Listener
    class ListenerController
      def initialize(listeners)
        start_listeners listeners
      end
      def start_listeners(listeners)
        threads = []
        begin
          listeners.each do |listener| 
            threads = Thread.new listener.start
          end
          threads.each {|t| t.join}
        rescue SignalException, SystemExit, Interrupt, StandardError, Exception => e
          # stop the threads
          threads.each {|t| Thread.kill t }
        end
      end
    end
  end
end