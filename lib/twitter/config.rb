require 'yaml'
require "twitter/config/version"

# The config file should have the following format:
#
#---
# reednj:
#   consumer_key: N5FP6mMnW6cBGdtBsBTLgE81s
#   consumer_secret: LrCTb5Y8JcO5gTvBswACu48p3IqmFPgX2yOG3c45GBh4MtmR1X
#   access_token: 11646642-5jJ7aL5Iq34BA9ZkuiewkkN7GxrTK1v69CnlUcVy1T
#   access_token_secret: dJ3D13bxuN0LvTEVN2JJhvDSmRk8CsgFFB1jGy7MARMJV
#
module Twitter::Config
	class YAMLConfig
		def self.for_user(username, options = {})
			path = options[:path] || "#{ENV['HOME']}/.trc"
			config_data = YAML.load_file path
			user_config = {}

			# we want to be able to handle two different formats - the simple one
			# with just a list of usernames, and the more complicated .trc format
			# that has the app ids in it etc
			if config_data['profiles'].nil?
				user_config = config_data[username]
			else
				user_config = config_data['profiles'][username].values.first
			end

			raise "no config found for #{username} in file #{path}" if user_config.nil?
			return user_config
		end
	end
end

module Twitter::REST
	class Client
		def self.from_config(username, options = {})
			trc_config = Twitter::Config::YAMLConfig.for_user username, options
			self.new({
				:consumer_key => trc_config['consumer_key'],
				:consumer_secret => trc_config['consumer_secret'],
				:access_token => trc_config['token'] || trc_config['access_token'],
				:access_token_secret => trc_config['secret'] || trc_config['access_token_secret']
			})
		end
	end
end
