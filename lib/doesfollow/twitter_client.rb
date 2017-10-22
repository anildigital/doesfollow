TWITTER_CONSUMER_KEY        = "4xH1hUHMSrtCbQWx9vR3dnEH6"
TWITTER_CONSUMER_SECRET             = "iRgc7l7SV6rYpfrUzDYDC3eWHrhY4k388aW5lbdOYoZMp9fXgY"
TWITTER_ACCESS_TOKEN           = "63603-OwRAHv2cN0HxGan5S8DYDc5ZpIG6yfVt2UWpazQQothc"
TWITTER_ACCESS_TOKEN_SECRET = "K0ehlL2AWEtywZOKmJE2zh9aeMkOYpWR2hiodH4dtKdAx"

require_relative "../doesfollow"

class Doesfollow::TwitterClient
  def get_friendship(source_screen_name, target_screen_name)
    friendship_resource = FriendshipShowRequest.new(source_screen_name, target_screen_name)
    friendship_json = call_api(friendship_resource)
    friendship_json
  end

  private

  def call_api(resource)
    access_token = prepare_access_token(TWITTER_ACCESS_TOKEN, TWITTER_ACCESS_TOKEN_SECRET)
    response = access_token.request(:get, resource.url)
    JSON.parse(response.body)
  end

  def prepare_access_token(oauth_token, oauth_token_secret)
    consumer = OAuth::Consumer.new(TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET, { :site => "https://api.twitter.com", :scheme => :header })
    token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
    OAuth::AccessToken.from_hash(consumer, token_hash)
  end
end

class FriendshipShowRequest
  attr_reader :url
  def initialize(source_screen_name, target_screen_name)
    @url = "https://api.twitter.com/1.1/friendships/show.json?source_screen_name=#{source_screen_name}&target_screen_name=#{target_screen_name}"
  end
end
