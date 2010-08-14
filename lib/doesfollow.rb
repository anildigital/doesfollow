require 'rest_client'
require 'json'

class DoesFollow

  def initialize(screen_name1, screen_name2)
    @screen_name1 = screen_name1
    @screen_name2 = screen_name2
    does_follow_strategy(DoesFollowDefault.new)
  end

  def does_follow_strategy(strategy_object)
    @does_follow_strategy = strategy_object
  end
  
  def doesfollow
    resource1 = "http://api.twitter.com/1/friends/ids.json?screen_name=#{@screen_name1}"
    resource2 = "http://twitter.com/users/show/#{@screen_name2}.json"
    
    user1_friends_json = get_resource_json(resource1)
    user2_json = get_resource_json(resource2)

    user1_friends_ids = user1_friends_json
    user2_id = user2_json["id"]

    @does_follow_strategy.doesfollow(user1_friends_json, user2_id)
  end

  private

  def get_resource_json(resource)
    response = RestClient.get resource
    response_json = JSON.parse(response)
    response_json
  end
end

class DoesFollowDefault

  def doesfollow(user1_friends_ids, user2_id)

    if user1_friends_ids.include?(user2_id)
      return true
    else
      return false
    end
  end
end

class DoesFollowConsole

  attr :output_streamer, true

  def doesfollow(user1_friends_ids, user2_id)

    if @output_streamer.nil?
      @output_streamer = $stdout
    end

    if user1_friends_ids.include?(user2_id)
      @output_streamer.puts("Yup\n\n")
    else
      @output_streamer.puts("Nope\n\n")
    end
  end
end
