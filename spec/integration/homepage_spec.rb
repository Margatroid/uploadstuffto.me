require 'spec_helper'
include Warden::Test::Helpers

describe 'homepage behaviour', :type => :feature do
  before { visit '/' }
  it "loads a page with the site's name" do
    expect(page).to have_content 'No more ideas'
  end

  it 'will display an upload field if and only if logged in' do
    user = Invite.create(:description => 'Test')
      .users
      .create(:email => 'test@test.com', :password => 'panzer vor')

    Warden.test_mode!
    login_as(user, :scope => user)
    expect(page).to have_content 'Upload images'

    logout(:user)
    expect(page).not_to have_content 'Upload images'
    Warden.test_reset!
  end
end
