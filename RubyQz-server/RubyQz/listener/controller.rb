trap("SIGINT") { raise SignalException.new :INT }
trap("SIGKILL") { raise SignalException.new :KILL }
trap("SIGABRT") { raise SignalException.new :ABRT }
trap("SIGTERM") { raise SignalException.new :TERM }

module RubyQz
  module Listener
    class Controller
      def initialize(listener)
        print "initializing controller\n"
        start_listener listener
      end
      def start_listener(listener)
        print "starting listener\n"
        threads = []
        begin
          # listeners.each do |listener| 
          thread = Thread.new listener.start
          thread.join
          # end
          # threads.each {|t| t.join}
        rescue SignalException, SystemExit, Interrupt, StandardError, Exception => e
          # stop the threads
          threads.each {|t| Thread.kill t }
        end
      end
    end
  end
end