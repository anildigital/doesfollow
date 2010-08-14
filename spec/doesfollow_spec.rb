require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "DoesFollow" do

  describe "When used from code" do 

    it "says anildigital follows defunkt is true" do
      users = DoesFollow.new("anildigital", "defunkt")
      users.doesfollow.should be_true
    end

    it "says arrahman follows anildigital is false" do
      users = DoesFollow.new("arrahman", "anildigital")
      users.doesfollow.should be_false
    end
  end

  describe "When used from console" do 

    before(:each) do
      @buffer = StringIO.new

      @doesfollow_strategy = DoesFollowConsole.new
      @doesfollow_strategy.output_streamer = @buffer
    end

    it "says anildigital follows defunkt is 'Yup'" do

      users = DoesFollow.new("anildigital", "defunkt")
      users.does_follow_strategy(@doesfollow_strategy)
      users.doesfollow

      @buffer.rewind
      @buffer.readlines.to_s.should include("Yup\n\n")
    end
    
    it "says arrahman follows anildigital is 'Nope'" do
      users = DoesFollow.new("arrahman", "anildigital")
      users.does_follow_strategy(@doesfollow_strategy)
      users.doesfollow

      @buffer.rewind
      @buffer.readlines.to_s.should include("Nope\n\n")
    end

  end

end
