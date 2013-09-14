require 'spec_helper'

describe 'homepage behaviour', :type => :feature do
  before { visit '/' }
  it "loads a page with the site's name" do
    expect(page).to have_content 'No more ideas'
  end

  it 'will display an upload field if and only if logged in' do
    user = Invite.create(:description => 'Test')
      .users
      .create(:email => 'test@test.com', :password => 'panzer vor')

    login_as(user, :scope => :user)
    expect(page).to have_content 'Upload images'

    logout(:user)
    expect(page).not_to have_content 'Upload images'
  end

  after(:each) do
    logout(:user)
    Warden.test_reset!
  end
end
