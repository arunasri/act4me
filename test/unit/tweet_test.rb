require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class TweetTest < ActiveSupport::TestCase

  context "Tweet instance" do
    setup { @tweet = Factory(:tweet) }

    should belong_to(:movie)
    should validate_uniqueness_of(:twitter_id).scoped_to(:movie_id)
    should allow_value("welcome to rt wle").for(:text)
    should allow_value("welcome to RTwle").for(:text)
    should_not allow_value("welcome to RT wle").for(:text)
  end

  context "Tweet instance" do

    should "mark as external if tweet is from external resource" do
      tweet = Factory(:tweet, :text => "this youtube http://youtube.com")

      assert tweet.external?
    end

    should "detect external links when text has http" do
      tweet = Tweet.new(:text => "this is external link to google http://google.com")

      assert tweet.url?
    end

    should "detect as non external links when text does not contain http" do
      tweet = Tweet.new(:text => "this is external link to google")

      assert !tweet.external?
    end

    should "set id from twitter as twitter_id" do
      tweet = Tweet.from_hashie!(:id => "234")

      assert "234", tweet.twitter_id
    end

    should "set created_on_twitter from created_at" do
      tweet = Tweet.from_hashie!(:created_at => "1/2/2009")
      assert "1/2/2009", tweet.created_on_twitter
    end
  end

  context "Tweet scopes" do
    setup do
      @movie     = Factory(:movie)
      @tweet     = Factory(:tweet, :movie => @movie)
      @positive  = Factory(:positive_tweet, :movie => @movie)
      @spotlight = Factory(:tweet, :movie => @movie, :featured => true)
      @negative  = Factory(:negative_tweet, :movie => @movie)
    end

    should "detect polarized tweets" do
      assert_same_elements [ @positive, @negative ], Tweet.polarized
    end

    should "detect featured tweets" do
      assert_same_elements [ @spotlight ], Tweet.spotlight

      @positive.update_attribute(:featured, true)
      assert_same_elements [ @positive, @spotlight ], Tweet.spotlight
    end

    should "detect reviewed tweets" do
      @positive.positive!
      @negative.negative!
      assert_same_elements [ @positive, @negative ], Tweet.assesed
      assert_does_not_contain Tweet.assesed, @tweet

      @tweet.positive!
      assert_same_elements [ @tweet, @positive, @negative ], Tweet.assesed
    end
  end
end
