require 'spec_helper'

describe 'uploaded images are private by default', :type => :feature do
  before(:each) do
    include UploadHelper
    @user = create(:user)
    login_as(@user, :scope => :user)

    Image.count.should eq 0

    3.times { |i| upload_test_file }
    logout(:user)

    Image.count.should eq 3

    visit "/users/#{ @user.username }"
  end

  context 'when logged out' do
    it "won't show private images on your profile" do
    end

    it "won't show private images on the homepage" do
    end
  end

  context 'when logged in' do
    it "will show private images on your profile" do
    end

    it "will show private images on the homepage" do
    end
  end
end