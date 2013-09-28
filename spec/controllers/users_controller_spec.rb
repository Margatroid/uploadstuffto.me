require 'spec_helper'

describe UsersController do
  describe "GET 'show'" do
    it "returns http success" do
      get :show, username: 'test'
      response.should be_success
    end
  end
end
