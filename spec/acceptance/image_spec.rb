require 'spec_helper'

describe 'image show page controls', :type => :feature do
  before(:each) do
    @you = create(:user)
    login_as(@you, :scope => :user)
    upload_test_file
    logout(:user)
  end

  it "does not show edit link if you don't own this image" do
    @me = create(:user)
    login_as(@me, :scope => :user)

    visit image_path(Image.first)

    page.should have_no_content('Edit')
  end

  it 'shows edit link if you own this image' do
    login_as(@you, :scope => :user)

    visit image_path(Image.first)

    click_link('Edit')
    page.should have_content('Edit')
  end

  after(:each) do
    logout(:user)
    Warden.test_reset!
  end
end