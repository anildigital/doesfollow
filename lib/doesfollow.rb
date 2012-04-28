require 'rest_client'
require 'json'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib', 'strategies'))
require 'doesfollow-default'

# Doesfollow represents for determining relationship
# between Twitter follower and followee
# You can instantiate it with follower and followee Twitter handles
#
#   obj = Doesfollow.new("anildigital", "defunkt")
#   obj.doesfollow
#
class Doesfollow

  def initialize(follower, followee)
    @follower = follower
    @followee = followee
    doesfollow_strategy(Strategies::Default.new)
  end
  
  # Set doesfollow strategy (default or console)
  def doesfollow_strategy(strategy_object)
    @doesfollow_strategy = strategy_object
  end

  def doesfollow
    doesfollow_status = get_doesfollow_status
    @doesfollow_strategy.doesfollow(doesfollow_status)
  end


  private

  def get_doesfollow_status
    get_friendship_json["relationship"]["target"]["followed_by"] == true
  end

  def get_friendship_json
    friendship_api_request = "https://api.twitter.com/1/friendships/show.json?source_screen_name=#{@follower}&target_screen_name=#{@followee}"
    friendship_json = get_resource_json(friendship_api_request)
    friendship_json
  end

  def get_resource_json(resource)
    response = RestClient.get resource
    response_json = JSON.parse(response)
    response_json
  end
end
