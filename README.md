# Thumper

Command line tool for inspecting RabbitMQ messages as they happen

## Installation

Add this line to your application's Gemfile:

    gem 'thumper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thumper

## Usage

To listen a RabbitMQ exchange


    thumper listen exchange-name

    Listening to exchange-name
    ctrl-c to stop listening


## TODO

- Add support for multiple exchanges
- Add support for specifying types of exchanges (only topic supported now)
- Add support for custom routing queues
- Better delivery_info and metadata output
- Better payload support
- Specs

## Contributing

1. Fork it ( https://github.com/danielmackey/thumper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Credits

[@jdoconnor](@jdoconnor) for the concept and initial connection code
