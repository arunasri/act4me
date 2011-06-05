require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "movies/edit.html.erb" do
  before(:each) do
    @movie = assign(:movie, Factory(:movie))
  end

  it "renders the edit movie form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => movies_path(@movie), :method => "post" do
    end
  end
end
