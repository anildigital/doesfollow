require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Doesfollow" do

  before(:each) do
    @does_anil_follow_defunkt = Doesfollow.new("anildigital", "defunkt")
    @does_rahman_follow_anil = Doesfollow.new("arrahman", "anildigital")
  end

  describe "When used from code" do

    it "says anildigital follows defunkt is true" do
      RestClient.stub(:get).and_return('{"relationship":{"target":{"followed_by":true}}}')
      @does_anil_follow_defunkt.doesfollow.should be_true
    end

    it "says arrahman follows anildigital is false" do
      RestClient.stub(:get).and_return('{"relationship":{"target":{"followed_by":false}}}')
      @does_rahman_follow_anil.doesfollow.should be_false
    end
  end

  describe "When used from console" do

    before(:each) do
      @buffer = StringIO.new
      @strategy = Strategies::Console.new
      @strategy.output_streamer = @buffer
    end

    it "says anildigital follows defunkt is Yup" do
      RestClient.stub(:get).and_return('{"relationship":{"target":{"followed_by":true}}}')
      
      @does_anil_follow_defunkt.doesfollow_strategy(@strategy)
      @does_anil_follow_defunkt.doesfollow
      @buffer.rewind
      @buffer.readlines.should include("Yup\n")
    end

    it "says arrahman follows anildigital is Nope" do
      RestClient.stub(:get).and_return('{"relationship":{"target":{"followed_by":false}}}')

      @does_rahman_follow_anil.doesfollow_strategy(@strategy)
      @does_rahman_follow_anil.doesfollow
      @buffer.rewind
      @buffer.readlines.should include("Nope\n")
    end
    
  end

end
