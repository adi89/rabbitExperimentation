#topic exchange.
require 'bunny'
connection = Bunny.new
connection.start

channel = connection.create_channel
exchange = channel.topic('news', :auto_delete => true)

#listen to any routingkey that starts w/ world.politics , # mark is like a wildcard that iwll match to 0 or more words.
channel.queue("", :exclusive => true).bind(exchange, :routing_key => 'world.politics.#').subscribe do |info, meta, payload|
  puts "on the topic of politics, #{payload}, routing key => #{info.routing_key}"
  end

#temp queue
#any routing key that ends w/ internetgovernance
  channel.queue("", :exclusive => true).bind(exchange, :routing_key => '#.internetgovernance').subscribe do |info, meta, payload|
  puts "on the topic of internetgovernance, #{payload}, routing key => #{info.routing_key}"
  end


#once
exchange.publish("People ponder relevance", :routing_key => "world.politics.smeting")


#otwice
exchange.publish("People ponder poop", :routing_key => "world.politics.internetgovernance")

sleep 1.0
connection.close