require 'socket'
require 'thread'

port = ARGV[0] || 8080

sock = Socket.new(:INET, :STREAM)
sock.bind(Socket.pack_sockaddr_in(port, '0.0.0.0'))
sock.listen(50000)

total_connections = 0

threads = []

puts "Listening on #{port}"

trap("INT") do
  puts "Shutting down..."
  puts total_connections
  sock.close

  threads.each { |th| th.join }

  exit
end


loop do
  client, _ = sock.accept
  th = Thread.new do
    total_connections += 1
    client.write("HTTP/1.0 200 OK\r\nContent-Type: text/plain\r\nContent-Length: 5\r\n\r\nPong!")
    client.close
    threads.delete(th)
  end

  threads << th
end
