#fanout exchange

require 'bunny'
connection = Bunny.new
connection.start

channel = connection.create_channel
exchange = channel.fanout('surf.swells')

channel.queue('adi', :auto_delete => true).bind(exchange).subscribe do |info, metadata, payload|
  puts "#{payload} => ian"
end

channel.queue("john", :auto_delete => true).bind(exchange).subscribe do |info, metadata, payload|
  puts "#{payload} => john"
end

exchange.publish("blah blah 1").publish("fkjfkdjfdk")

sleep 1.0
connection.close