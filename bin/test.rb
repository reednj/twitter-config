#!/usr/bin/env ruby

require 'twitter/config'

client = Twitter::REST::Client.from_config('reednj', :path => "#{ENV['HOME']}/.trc")