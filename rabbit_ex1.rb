require 'bunny'
require 'pry'


connection = Bunny.new
connection.start

channel = connection.create_channel

q1 = channel.queue('postoffice.mick', :auto_delete => true)
q2 = channel.queue('postoffice.roni', :auto_delete => true)
q3 = channel.queue('postoffice.ian', :auto_delete => true)

exchange= channel.default_exchange

q1.subscribe do |info, metadata, payload|
  binding.pry
  puts "mick's box received #{payload}"
end

q2.subscribe do |info, metadata, payload|
  binding.pry
  puts "roni's box received #{payload}"
end

q3.subscribe do |info, metadata, payload|
  binding.pry
  puts "ian's box received #{payload}"
end
#each queue took the message it was given (payload), interpolated and made it a string.
exchange.publish("This is a test", :routing_key => "postoffice.ian").publish("Blah balh", :routing_key => "postoffice.mick").publish("toyoyoyo", :routing_key => "postoffice.roni")

sleep 1.0
connection.close