#coding: utf-8
require 'cgi'
require 'eventmachine'
require 'em-websocket'

MAXLOG = 10
c = 1

EventMachine::run do

  @channel = EventMachine::Channel.new
  @logs = Array.new

  @channel.subscribe do |m|
    @logs.push m
    @logs.shift if @logs.size > MAXLOG
  end

  EventMachine::WebSocket.start(
    :host => "0.0.0.0",
    :port => 3030
  ) do |ws|
    # 接続した
    ws.onopen {
      puts "WebSocket open"
      c+=1
      sid = @channel.subscribe do |m|
        #ws.send "こんにちわクライアント#{c}さん"
        ws.send m
      end

      @logs.each do |m|
        ws.send m
      end

      @channel.push "#{CGI.escape('こんにちわ')} <#{sid}>"

      # チャンネルに対してsidメッセージを送る
      ws.onmessage {|m|
        puts "<#{sid}> #{CGI.unescape(m)}"
        @channel.push "#{CGI.escape('テスト')} <#{sid}> #{m}"
      }

      # 切断した
      ws.onclose {
        puts "WebSocket closed"
        @channel.unsubscribe sid
        @channel.push "<#{sid}> disconnect"
      }

    }

#   # メッセージを送る
#   ws.onmessage {|msg|
#     puts "On Message"
#     ws.send "Pong: #{msg}"
#   }

#   # 切断した
#   ws.onclose {
#     puts "WebSocket closed"
#   }

  end

#  EventMachine.add_periodic_timer(5) do
#  end

  # n秒毎に時間を送信する
  EventMachine::defer do
    loop do
      puts Time.now.to_s
      @channel.push Time.now.to_s
      sleep 5
    end
  end

end
