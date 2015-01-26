require 'thumper'

module Thumper
  class Counter
    def initialize
      @counter = {}
    end

    def increment(key)
      if @counter.has_key? key
        @counter[key] += 1
      else
        @counter[key] = 1
      end
    end

    def render
      puts "-- Counters --"
      @counter.each do |key, count|
        puts "#{key}: #{count}"
      end
      puts "\n"
    end
  end
end