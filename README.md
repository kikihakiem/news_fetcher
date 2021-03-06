[![Build Status](https://travis-ci.org/kikihakiem/news_fetcher.svg?branch=master)](https://travis-ci.org/kikihakiem/news_fetcher)

# NewsFetcher

`news_fetcher` is a gem to download, extract and publish news to redis.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'news_fetcher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install news_fetcher

## Usage

Run via rake task:

```bash
git clone git@github.com:kikihakiem/news_fetcher.git
cd news_fetcher
bundle exec rake install
bundle exec rake fetch
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the specs. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kikihakiem/news_fetcher.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

