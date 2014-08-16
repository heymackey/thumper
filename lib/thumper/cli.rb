require 'thor'
require 'thumper'

module Thumper
  class CLI
    class Base < Thor
      desc 'version', 'Shows the Thumper version number'
      def version
        say Thumper::VERSION
      end

      desc 'listen <exchange name>', 'Listen to a RabbitMQ exchange with <exhange name>'
      def listen(name)
        say "Listening to #{name}"
        say "ctrl-c to stop listening"

        connection = Bunny.new
        connection.start

        channel = connection.create_channel
        queue   = channel.queue 'thumper', auto_delete: true
        running = true

        Signal.trap('INT') { running = false }

        while running do
          queue.bind(channel.topic(name), routing_key: '#')
          queue.subscribe(ack: true) do |delivery_info, metadata, payload|
            puts "delivery_info: #{delivery_info[:routing_key]}"
            puts "metadata: #{metadata}"
            puts "payload: #{payload}"
            puts "\n"
          end
        end

        connection.close
      end
    end
  end
end
