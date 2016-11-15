# LeBonData

A small gem to parse _Le Bon Coin_(tm).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lebondata'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lebondata

## Usage

``` ruby

client = LeBonData::Client.new

offers = client.search(region: 'ile_de_france',
                       category: 'livres',
                       q: 'Assassin royal')

offers.each do |offer|
  # Uncomment to load the offer details from the offer page
  # Without it, you're just getting date from the search results
  # offer.load!

  puts "Found an offer: #{offer.title}"
  puts "  details on #{offer.href}"
  puts "  attributes: #{offer.attr}"
end
```

## Development

After checking out the repo, run `bin/setup` to install
dependencies. Then, run `rake spec` to run the tests. You can also run
`bin/console` for an interactive prompt that will allow you to
experiment.

To install this gem onto your local machine, run `bundle exec rake
install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/[USERNAME]/lebondata. This project is intended to
be a safe, welcoming space for collaboration, and contributors are
expected to adhere to
the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.


## License

The gem is available as open source under the terms of
the [MIT License](http://opensource.org/licenses/MIT).
