# Dir["#{File.dirname(__FILE__)}/**/*.rb"].each { |f| require(f) if f.end_with?(".rb") }



(Dir["#{File.dirname(__FILE__)}/**/*.rb"]-[File.join(File.dirname(__FILE__), __FILE__)]).each { |f|  }
