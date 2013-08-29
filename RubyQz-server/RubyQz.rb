#!/usr/bin/env ruby
#===============================
# RubyQz daemon
#
require 'RubyQz/Config/config.rb'


trap("SIGINT") { raise SignalException.new :INT }
trap("SIGKILL") { raise SignalException.new :KILL }
trap("SIGABRT") { raise SignalException.new :ABRT }
trap("SIGTERM") { raise SignalException.new :TERM }

module RubyQzDaemon
  def self::start
    puts "starting \e[37;41m Ruby\e[33mQz \e[37;40m daemon, pid #{Process.pid}"
    begin 
      # for the meantime, lets put a sleep here.
        begin
          config = Config.new
        rescue Exception => ce
          puts "Configuration exception #{e}" 
        end
        
        sleep
    rescue SignalException, SystemExit, Interrupt, StandardError, Exception => e
      puts "stopping... #{e}"
    end
  end

end

RubyQzDaemon.start
puts "stopped"
