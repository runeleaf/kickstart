#coding: utf-8
require 'em-http-request'

EventMachine.run do
  http = EventMachine::HttpRequest.new("ws://localhost:3030/websocket").get :timeout => 0

  http.errback {
    puts "oops"
  }

  http.callback {
    puts "WebSocket connected!"
    http.send("ok ok ok ok ok ok ok")
  }

  http.stream {|m|
    #sleep 3
    #exit
  }

  http.disconnect {
    puts "disconnect"
  }
end

