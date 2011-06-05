require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "movies/show.html.erb" do
  before(:each) do
    @movie = assign(:movie, Factory(:movie))
    tweets = []
    tweets.stub(:next_page).and_return(nil)
    @tweets = assign(:tweets, tweets)
  end

  it "renders attributes in <p>" do
    render
  end
end
