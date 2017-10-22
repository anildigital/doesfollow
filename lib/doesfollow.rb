require 'json'
require 'oauth'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib', 'strategy'))
require_relative './strategy/default'


# Doesfollow represents for determining relationship
# between Twitter source_screen_name and target_screen_name
# You can instantiate it with source_screen_name and target_screen_name Twitter handles
#
#   obj = Doesfollow.new("anildigital", "defunkt")
#   obj.doesfollow
#
class Doesfollow

  def initialize(source_screen_name, target_screen_name)
    @source_screen_name = source_screen_name
    @target_screen_name = target_screen_name
    doesfollow_strategy(Strategy::Default.new)
  end

  # Set doesfollow strategy (default or console)
  def doesfollow_strategy(strategy_object)
    @doesfollow_strategy = strategy_object
  end

  def doesfollow
    status = get_doesfollow_status(@source_screen_name, @target_screen_name)
    @doesfollow_strategy.doesfollow(status)
  end

  private

  def get_doesfollow_status(source_screen_name, target_screen_name)
    twitter_client = Doesfollow::TwitterClient.new
    friendship_json = twitter_client.get_friendship(source_screen_name, target_screen_name)
    doesfollow?(friendship_json)
  end

  def doesfollow?(json)
    json["relationship"]["target"]["followed_by"] == true
  end
end


require_relative './doesfollow/twitter_client'
