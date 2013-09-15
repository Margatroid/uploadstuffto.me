require 'spec_helper'

module UploadHelper
  def upload_file
    visit '/'
    attach_file('File', File.expand_path('spec/fixtures/chicken_rice.jpg'))
    click_button 'Upload image'
  end
end

describe 'homepage upload', :type => :feature do
  include UploadHelper

  before(:each) do
    @registered_user = Invite.create(:description => 'even')
      .users
      .create(:email => 'electronic@bra.in', :password => 'pancakecrystal')

    login_as(@registered_user, :scope => :user)
  end

  it 'will let me upload an image from disk' do
    upload_file

    current_path.should eq(image_path(1))
    expect(page).to have_content 'Image uploaded successfully'
  end

  it 'will have a working short link after uploading an image' do
    upload_file

    visit "/images/#{ Image.first.key }"
    page.status_code.should be 200
  end

  after(:each) do
    logout(:user)
    Warden.test_reset!
  end
end
