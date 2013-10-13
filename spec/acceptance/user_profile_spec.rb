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

  it 'shows their join date' do
    expect(page).to have_content(
      "Joined #{ @user.created_at.strftime('%Y-%m-%d') }"
    )
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

describe 'image gallery', :type => :feature do
  context 'when logged in' do
    it 'shows images you uploaded' do
      user = create(:user)
      login_as(user, :scope => :user)
      upload_test_file
      upload_test_another_file

      visit "/profile/#{ user.username }"
      gallery_links = page.all(:css, '#recent_uploads .small-tile a')
      recently_upload_images = page.all(:css, '#recent_uploads .small-tile img')

      srcs  = recently_upload_images.map { |image| image[:src] }
      hrefs = gallery_links.map { |link| link[:href] }

      expected_srcs  = Image.all.map { |image| image.file.url(:thumb) }
      expected_hrefs = Image.all.map do |image|
        Rails.application.routes.url_helpers.image_path(image)
      end

      srcs.should    =~ expected_srcs
      expected_hrefs =~ expected_hrefs
    end
  end

  context 'when logged out' do
    it 'shows only your public images' do
    end
  end
end

describe 'image gallery pagination' do
  context 'when over 50 images' do
    it 'shows pagination controls' do
    end

    it 'will let you go to page 2' do
    end

    it 'will have 60th image on page 2' do
    end

    it 'will not have 60th image on the first page' do
    end
  end

  context 'when 50 or less images' do
    it 'does not show any pagination controls' do
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