require 'spec_helper'

include UploadHelper

describe 'correct routing to profile', :type => :feature do
  it 'will load the profile at the correct path' do
    user = create(:user)
    visit "/profile/#{ user.username }"
    page.status_code.should be 200
  end
end

describe 'user profile header', :type => :feature do
  before(:each) do
    @user = create(:user)
    login_as(@user, :scope => :user)

    4.times { |i| upload_test_file }
    2.times { |i| upload_test_another_file }

    logout(:user)

    visit "/profile/#{ @user.username }"
  end

  it "shows the user's name" do
    expect(page).to have_content @user.username
  end

  context 'when logged in' do
    it 'shows how many images you have' do
      login_as(@user, :scope => :user)
      expect(page).to have_content '6 images'
    end
  end

  context 'when logged out' do
    it 'shows how many public images you have' do
    end
  end

  after(:each) do
    logout(:user)
    Warden.test_reset!
  end
end

describe 'image gallery' do
  context 'when logged in' do
    it 'shows all the images you uploaded' do
    end
  end

  context 'when logged out' do
    it 'shows only your public images' do
    end
  end
end

describe 'album gallery' do
  context 'when logged in' do
    it 'shows all the albums you created' do
    end
  end

  context 'when logged out' do
    it 'shows only the public albums you created' do
    end
  end
end