require 'spec_helper'

describe 'homepage upload', :type => :feature do
  before(:each) do
    @registered_user = Invite.create(:description => 'even')
      .users
      .create(:email => 'electronic@bra.in', :password => 'pancakecrystal')

    login_as(@registered_user, :scope => :user)
  end

  it 'will let me upload an image from disk' do
    visit '/'
    attach_file('File', File.expand_path('spec/fixtures/chicken_rice.jpg'))

    click_button 'Upload image'
    current_path.should eq(image_path(1))
    expect(page).to have_content 'Image uploaded successfully'
  end

  after(:each) do
    logout(:user)
    Warden.test_reset!
  end
end
