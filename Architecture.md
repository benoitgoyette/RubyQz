# RubyQz

This is the working document for the Architecture lines of RubyQz. As the project evolves, this document will be evolve jointly.

## Architecture lines

1. RubyQz-server Components
1.1. Listener Interface 
1.1.1. Http Interface with Rack
1.1.2. Ruby DRB Interface


1.2. Core Queue Manager
1.2.1 Queue Receiver and Dispatcher
1.2.2 Queue Consumer 

1.3. Storage
1.3.1. Storage Interface
1.3.2. File Storage
1.3.3. DB Storage
1.3.2. NoSql Storage

1.4. Queue Daemon
1.4.1. Configuration Manager

2. Client Components
2.1.  RubyQz-client Producer/Consumer Gem
2.1.1. DRB client
2.1.2. Http client
