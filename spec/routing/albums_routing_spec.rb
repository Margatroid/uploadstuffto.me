require "spec_helper"

describe AlbumsController do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/albums").not_to be_routable
    end

    it 'routes to #index with username param' do
      get('/users/x/albums').should route_to('albums#index', username: 'x')
    end

    it "routes to #new" do
      get("/albums/new").should route_to("albums#new")
    end

    it "routes to #show" do
      get("/albums/abcde").should route_to("albums#show", :key => "abcde")
    end

    it "routes to #edit" do
      get("/albums/abcde/edit").should route_to("albums#edit", :key => "abcde")
    end

    it "routes to #create" do
      post("/albums").should route_to("albums#create")
    end

    it "routes to #update" do
      patch("/albums/abcde").should route_to("albums#update", :key => "abcde")
    end

    it "routes to #destroy" do
      delete("/albums/abcde").should route_to("albums#destroy", :key => "abcde")
    end
  end
end
