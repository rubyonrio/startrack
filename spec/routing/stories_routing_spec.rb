require "spec_helper"

describe StoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/stories").should route_to("stories#index")
    end

    it "routes to #new" do
      get("/stories/new").should route_to("stories#new")
    end

    it "routes to #show" do
      get("/stories/1").should route_to("stories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/stories/1/edit").should route_to("stories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/stories").should route_to("stories#create")
    end

    it "routes to #update" do
      put("/stories/1").should route_to("stories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/stories/1").should route_to("stories#destroy", :id => "1")
    end

  end
end
