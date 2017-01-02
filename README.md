# Twitter::Config

Lets the twitter gem load its tokens from a config file, instead of having to be specified in code.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twitter-config'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twitter-config

## Usage

This gem makes it easy to load the user tokens from a config file for the api. It uses the standard `.trc` format from the `t` command line gem. You can use this gem to configure the tokens for new accounts as well.

```ruby
require 'twitter'
require 'twitter/config'

# if you don't specify the config file it will look for ~/.trc ...
client = Twitter::REST::Client.from_config('reednj')

# but you can specify it explicitly
client = Twitter::REST::Client.from_config('reednj', :path => "./trc.yaml")
```

## Config file format

Two file formats are supported - a simpiler that is meant to be manually configured, and the more complicated `.trc` format. 

The simpler format:

```yaml
---
reednj:
    consumer_key: N5FP6mMnW6cBGdtBsBTLgE81s
    consumer_secret: ...
    access_token: ...
    access_token_secret: ...
reddit_stream:
    consumer_key: ...
    consumer_secret: ...
    access_token: ...
    access_token_secret: ...
```

Use the `t` twitter command line client to manage the `.trc` format. If you already have this installed, then you should be able to use `twitter-config` without any configuring anything.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
