require "spec_helper"

describe ImagesController do
  describe "routing" do

    it "routes to #show" do
      get("/images/hello").should route_to("images#show", :key => "hello")
    end

    it "routes to #edit" do
      get("/images/hello/edit").should route_to("images#edit", :key => "hello")
    end

    it "routes to #create" do
      post("/images").should route_to("images#create")
    end

    it "routes to #update" do
      patch("/images/hello").should route_to("images#update", :key => "hello")
    end

    it "routes to #destroy" do
      delete("/images/hello").should route_to("images#destroy", :key => "hello")
    end

  end
end
