require 'rest_client'
require 'json'

class Doesfollow

  def initialize(follower, followee)
    @follower = follower
    @followee = followee
    does_follow_strategy(DoesfollowDefault.new)
  end

  def does_follow_strategy(strategy_object)
    @does_follow_strategy = strategy_object
  end

  def doesfollow
    user1_friends_ids, user2_id = get_user_id_and_friend_ids
    @does_follow_strategy.doesfollow(user1_friends_ids, user2_id)
  end


  private

  def get_user_id_and_friend_ids
    friends_json =
      "http://api.twitter.com/1/friends/ids.json?screen_name=#{@follower}"

    user_json = "http://twitter.com/users/show/#{@followee}.json"

    friends_json = get_resource_json(friends_json)
    user_json = get_resource_json(user_json)

    friends_ids = friends_json["ids"]
    user_id = user_json["id"]
    [friends_ids, user_id]
  end

  def get_resource_json(resource)
    response = RestClient.get resource
    response_json = JSON.parse(response)
    response_json
  end
end

class DoesfollowDefault

  def doesfollow(user1_friends_ids, user2_id)
    if user1_friends_ids.include?(user2_id)
      true
    else
      false
    end
  end

end

class DoesfollowConsole

  attr :output_streamer, true

  def doesfollow(user1_friends_ids, user2_id)

    if @output_streamer.nil?
      @output_streamer = $stdout
    end

    if user1_friends_ids.include?(user2_id)
      @output_streamer.puts("Yup")
    else
      @output_streamer.puts("Nope")
    end
  end
end
