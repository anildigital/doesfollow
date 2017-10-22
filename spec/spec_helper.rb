$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib', 'strategy'))


require_relative '../lib/doesfollow/twitter_client.rb'
require_relative '../lib/strategy/default.rb'
require_relative '../lib/strategy/console.rb'
require 'doesfollow'
require 'rspec'
