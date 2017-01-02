#!/usr/bin/env ruby
require 'twitter'
require 'twitter/config'

client = Twitter::REST::Client.from_config('reednj', :path => "#{ENV['HOME']}/.trc")
puts client.user_timeline.first.text
