#coding: utf-8
require 'eventmachine'
require 'em-http-request'

EventMachine.run {
  http = EventMachine::HttpRequest.new("ws://localhost:3030/websocket").get :timeout => 0

  http.errback {
    puts "oops"
  }
  http.callback {
    puts "WebSocket connected!"
    http.send("ok ok ok ok ok ok ok")
  }

  http.stream { |msg|
    puts "Recieved: #{msg}"
    http.send "Pong: #{msg}"
  }
}
