require 'spec_helper'

describe "users/show.html.erb" do
  it 'should have a username' do
    user = stub_model(User, :username => 'berg_katze')
    assign(:user, user)
    render template: 'users/show'
    rendered.should have_text("berg_katze's profile")
  end
end
