require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Doesfollow" do

  describe "When used from code" do

    it "says anildigital follows defunkt is true" do
      users = Doesfollow.new("anildigital", "defunkt")

      users.stub(:get_user_id_and_friend_ids).
        and_return([["1", "2", "3"], "1"])

      users.doesfollow.should be_true
    end

    it "says arrahman follows anildigital is false" do
      users = Doesfollow.new("arrahman", "anildigital")

      users.stub(:get_user_id_and_friend_ids).
        and_return([["1", "2", "3"], "4"])

      users.doesfollow.should be_false
    end
  end

  describe "When used from console" do

    before(:each) do
      @buffer = StringIO.new
      @strategy = DoesfollowConsole.new
      @strategy.output_streamer = @buffer
    end

    it "says anildigital follows defunkt is Yup" do
      users = Doesfollow.new("anildigital", "defunkt")
      users.does_follow_strategy(@strategy)

      users.stub(:get_user_id_and_friend_ids).
        and_return([["1", "2", "3"], "1"])

      users.doesfollow
      @buffer.rewind
      @buffer.readlines.should include("Yup\n")
    end

    it "says arrahman follows anildigital is Nope" do
      users = Doesfollow.new("arrahman", "anildigital")
      users.does_follow_strategy(@strategy)

      users.stub(:get_user_id_and_friend_ids).
        and_return([["1", "2", "3"], "4"])

      users.doesfollow
      @buffer.rewind
      @buffer.readlines.should include("Nope\n")
    end
  end

end
