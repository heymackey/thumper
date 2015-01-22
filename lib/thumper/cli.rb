require 'thor'
require 'thumper'

module Thumper
  class CLI
    class Base < Thor
      desc 'version', 'Shows the Thumper version number'
      def version
        say Thumper::VERSION
      end

      desc 'listen <exchange name> [<host name>]', 'Listen to a RabbitMQ exchange with <exhange name> on [<host name>||localhost]'
      def listen(name, host = nil)
        say "Listening to #{name}"
        say "ctrl-c to stop listening"

        connection = Bunny.new(host)
        connection.start

        channel = connection.create_channel
        queue   = channel.queue 'thumper', auto_delete: true
        routing_keys_count = {}
        running = true

        Signal.trap('INT') { running = false }

        while running do
          queue.bind(channel.topic(name), routing_key: '#')
          queue.subscribe(manual_ack: true) do |delivery_info, metadata, payload|
            routing_key = delivery_info[:routing_key]
            puts "delivery_info: #{routing_key}"
            puts "metadata: #{metadata}"
            if metadata[:content_type] == 'application/json'
              json = JSON.parse(payload)
              puts JSON.pretty_generate(json)
            else
              puts "payload: #{payload}"
            end
            puts "\n"

            increment_routing_key_counts(routing_keys_count, routing_key)
          end
        end

        puts "\n\n-- Routing Key Counts --"
        routing_keys_count.each do |key, count|
          puts "#{key}: #{count}"
        end

        connection.close
      end

      private

        def increment_routing_key_counts(counts_hash, key)
          if counts_hash.has_key? key
            counts_hash[key] += 1
          else
            counts_hash[key] = 1
          end
        end
    end
  end
end
