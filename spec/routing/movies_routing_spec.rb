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

    it "routes to #edit_fresh" do
      get("/movies/1-telugu/edit_fresh").should route_to("movies#edit_fresh", :id => "1-telugu")
    end

    it "routes to #edit_mixed" do
      get("/movies/1-telugu/edit_mixed").should route_to("movies#edit_mixed", :id => "1-telugu")
    end

    it "routes to #mixed" do
      get("/movies/1-telugu/mixed").should route_to("movies#mixed", :id => "1-telugu")
    end

    it "routes to #closest" do
      get("/movies/1-telugu/closest").should route_to("movies#closest", :id => "1-telugu")
    end

    it "routes to #terminate" do
      get("/movies/1-telugu/terminate").should route_to("movies#terminate", :id => "1-telugu")
    end

    it "routes to #edit_terminate" do
      get("/movies/1-telugu/edit_terminate").should route_to("movies#edit_terminate", :id => "1-telugu")
    end

    it "routes to #edit_external" do
      get("/movies/1-telugu/edit_external").should route_to("movies#edit_external", :id => "1-telugu")
    end

    it "routes to #edit_positive" do
      get("/movies/1-telugu/edit_positive").should route_to("movies#edit_positive", :id => "1-telugu")
    end

    it "routes to #positive" do
      get("/movies/1-telugu/positive").should route_to("movies#positive", :id => "1-telugu")
    end

    it "routes to #edit_negative" do
      get("/movies/1-telugu/edit_negative").should route_to("movies#edit_negative", :id => "1-telugu")
    end

    it "routes to #negative" do
      get("/movies/1-telugu/negative").should route_to("movies#negative", :id => "1-telugu")
    end

    it "routes to #edit_assesed" do
      get("/movies/1-telugu/edit_assesed").should route_to("movies#edit_assesed", :id => "1-telugu")
    end

    it "routes to #create" do
      post("/movies").should route_to("movies#create")
    end

    it "routes to #update" do
      put("/movies/1-telugu").should route_to("movies#update", :id => "1-telugu")
    end

    it "routes to #sync" do
      put("/movies/1-telugu/sync").should route_to("movies#sync", :id => "1-telugu")
    end
  end
end
