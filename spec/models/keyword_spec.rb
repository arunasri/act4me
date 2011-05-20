require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Keyword, "#validations" do
  before(:each) { @keyword = Factory(:keyword) }
  it { should validate_uniqueness_of(:name).scoped_to(:movie_id) }
  it { should validate_presence_of(:name) }
end

describe Keyword do

  context "Keyword when searching on twitter" do

    it "add since_id if since_id is present on keyword" do
      keyword = Keyword.new(:name => 'tweet',:since_id => 234)
      twitter = mock()
      twitter.should_receive(:since).with(234).and_return('twitter')
      keyword.stub(:search_instance).and_return(twitter)

      assert_equal 'twitter', keyword.add_since_to_search
    end

    it "add movie release date if since_id is nil on keyword" do
      keyword = Keyword.new(:name => 'tweet')
      movie   = mock(:released_on => 'today')
      twitter = mock()

      twitter.should_receive(:since_date).with('today').and_return('twitter')
      keyword.should_receive(:movie).and_return(movie)
      keyword.should_receive(:search_instance).and_return(twitter)

      assert_equal 'twitter', keyword.add_since_to_search
    end

    it "update since id with last tweet id create_tweets" do
      keyword = Factory(:keyword)
      tweet   = Factory.build(:tweet)

      keyword.stub(:to_tweets).and_return([ tweet ])

      keyword.create_tweets
    end

    it "not update since id if no valid tweets present" do
      keyword = Factory(:keyword)
      keyword.stub(:to_tweets).and_return([])
      keyword.create_tweets

      keyword.since_id.should be_nil
    end

    it "set page number and per_page and since_id before each request" do
      keyword = Keyword.new(:name => 'tweet')
      keyword.should_receive(:movie).and_return(mock(:released_on => 'today'))
      keyword.prepare_params_for(1)

      assert_equal 100, keyword.search_instance.query[:rpp]
      assert_equal 'today', keyword.search_instance.query[:since]
      assert_equal ['tweet'], keyword.search_instance.query[:q]
    end

    it "set passed page number" do
      keyword = Keyword.new(:name => 'tweet', :since_id => 23)
      keyword.prepare_params_for(4)

      assert_equal 4, keyword.search_instance.query[:page]
    end
  end
end
