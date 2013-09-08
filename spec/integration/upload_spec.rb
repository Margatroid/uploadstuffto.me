require 'spec_helper'
include Warden::Test::Helpers

describe 'homepage upload', :type => :feature do
  before(:each) do
    @registered_user = Invite.create(:description => 'even')
      .users
      .create(:email => 'electronic@bra.in', :password => 'pancakecrystal')

    Warden.test_mode!
    login_as(@registered_user, :scope => :user)
  end

  it 'will let me upload an image from disk' do
    visit '/'
    attach_file('Upload', File.expand_path('spec/assets/chicken_rice.jpg'))
  end

  after(:each) do
    Warden.test_reset!
  end
end
