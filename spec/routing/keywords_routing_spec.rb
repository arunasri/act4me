require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KeywordsController do
  describe "routing" do
    it "routes to #create" do
      post("/movies/2-telugu/keywords").should route_to("keywords#create", :movie_id => "2-telugu")
    end
    it "routes to #destroy" do
      delete("/keywords/1").should route_to("keywords#destroy", :id => "1")
    end
  end
end
