require 'spec_helper'

describe 'homepage upload', :type => :feature do
  include UploadHelper

  before(:each) do
    user = create(:user)
    login_as(user, :scope => :user)
  end

  it 'will let me upload an image from disk' do
    Image.count.should eq 0
    upload_test_file

    current_path.should eq(image_path(Image.first.key))
    Image.count.should eq 1
    expect(page).to have_content 'Image uploaded successfully'
  end

  it 'will have a working short link after uploading an image' do
    upload_test_file

    visit "/images/#{ Image.first.key }"
    page.status_code.should be 200

    img = page.find_by_id('fullsize_image')
    visit img[:src]
    page.status_code.should be 200
  end

  it 'will save the file in the correct location' do
    upload_test_file

    visit "/full/#{ Image.first.key }.jpg"
    page.status_code.should be 200
  end

  after(:each) do
    logout(:user)
    Warden.test_reset!
  end
end
