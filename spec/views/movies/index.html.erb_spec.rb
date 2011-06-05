require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "movies/index.html.erb" do
  before(:each) do
    movies = [
      Factory(:movie),
      Factory(:movie)
    ]
    movies.stub(:next_page).and_return(2)
    assign(:movies, movies)
  end

  it "renders a list of movies" do
    render
  end
end
