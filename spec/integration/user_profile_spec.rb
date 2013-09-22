require 'spec_helper'

include UploadHelper, UserFactory

describe 'correct routing to profile', :type => :feature do
  it 'will load the profile at the correct path' do
    user = create(:user)
  end
end

describe 'user profile header', :type => :feature do
  it "shows the user's name" do
  end

  context 'when logged in' do
    it 'shows how many images you have' do
    end
  end

  context 'when logged out' do
    it 'shows how many public images you have' do
    end
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