require 'rubygems'
require 'rack/test'
require 'test/unit'
require 'twitter/config'

class ConfigTest < Test::Unit::TestCase
	include Rack::Test::Methods

    def assert_is_a(v, type)
        assert v.is_a?(type), "Expected #{type} but got #{v.class}"
    end

    def valid_config!(config)
        assert_not_nil config
        assert config.is_a? Hash

        assert_is_a config[:consumer_key], String
        assert_is_a config[:consumer_secret], String
        assert_is_a config[:access_token], String
        assert_is_a config[:access_token_secret], String

        assert config[:consumer_key].length > 8, 'string too short'
        assert config[:consumer_secret].length > 8, 'string too short'
        assert config[:access_token].length > 8, 'string too short'
        assert config[:access_token_secret].length > 8, 'string too short'
    end

    def test_simple_config
        config = Twitter::Config::YAMLConfig.for_user('reednj', :path => './test/simple.yaml')
        valid_config! config
    end

    def test_trc_config
        config = Twitter::Config::YAMLConfig.for_user('top_reddit_gold', :path => './test/trc.yaml')
        valid_config! config
        assert config[:access_token_secret] == "QPAstuv77w7CtuVe1234gItL7OUL1t0ndpNr3Km"
    end

    def test_missing_user
        begin
            Twitter::Config::YAMLConfig.for_user('fake_user', :path => './test/simple.yaml')
        rescue
            thrown = true
        end

        assert thrown, "exception not thrown for missing user"

    end

    def test_default_file_load
        ENV['HOME'] = './test'
        valid_config! Twitter::Config::YAMLConfig.for_user('reednj')
    end
end
