require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MoviesController do
  describe "routing" do

    it "routes to #index" do
      get("/movies").should route_to("movies#index")
    end

    it "routes to #index second page" do
      get("/movies/2").should route_to("movies#index", :page => "2")
    end

    it "routes to #new" do
      get("/movies/new").should route_to("movies#new")
    end

    it "routes to #show" do
      get("/movies/1-telugu").should route_to("movies#show", :id => "1-telugu")
    end

    it "routes to #edit" do
      get("/movies/1-telugu/edit").should route_to("movies#edit", :id => "1-telugu")
    end

    it "routes to #create" do
      post("/movies").should route_to("movies#create")
    end

    it "routes to #update" do
      put("/movies/1-telugu").should route_to("movies#update", :id => "1-telugu")
    end
  end
end
