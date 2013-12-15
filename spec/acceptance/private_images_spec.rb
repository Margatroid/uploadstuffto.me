require 'spec_helper'

describe 'private images', :type => :feature do
  before(:each) do
    include UploadHelper
    @featured_user = create(:user, :featured => true)
    login_as(@featured_user, :scope => :user)

    Image.count.should eq 0

    3.times { |i| upload_test_file }
    logout(:user)

    Image.count.should eq 3
  end

  context 'when logged out' do
    before(:each) { Image.update_all(:public => false) }

    it "won't show private images on your profile" do
      visit "/users/#{ @featured_user.username }"
      Image.all.each { |i| puts "I am public? #{ i.public? }" }
      page.has_css?('#recent_uploads .small-img img').should eq(false)
    end

    it "won't show private images on the homepage (when you're featured)" do
      visit "/"
      page.has_css?('#recent_uploads .small-img img').should eq(false)
    end

    after(:each) { Image.update_all(:public => true) }
  end

  context 'when logged in' do
    before(:each) do
      login_as(@featured_user, :scope => :user)
    end

    it "will show private images on your profile" do
      visit "/users/#{ @featured_user.username }"

      # Fetch all images visible on profile page.
      recently_upload_images = page.all(:css, '#recent_uploads .small-img img')
      srcs  = recently_upload_images.map { |image| image[:src] }

      expected_srcs  = Image.all.map { |image| image.file.url(:thumb) }
      srcs.should    =~ expected_srcs
    end

    it "will show private images on the homepage" do
      visit "/"

      # Fetch all images visible on the homepage.
      recently_upload_images = page.all(:css, '#my_recent_uploads .small-img img')
      srcs  = recently_upload_images.map { |image| image[:src] }

      expected_srcs  = Image.all.map { |image| image.file.url(:thumb) }
      srcs.should    =~ expected_srcs
    end

    after(:each) do
      logout(:user)
      Warden.test_reset!
    end
  end
end