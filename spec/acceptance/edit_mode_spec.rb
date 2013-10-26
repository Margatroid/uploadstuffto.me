require 'spec_helper'

describe 'deletion', :type => :feature do
  before(:each) do
    @me = create(:user_with_images)
    login_as(@me, :scope => :user)

    visit "/users/#{ @me.username }"
    click_link 'Edit mode'
  end

  it 'lets you delete an image' do
    # Find last image, @me.images.first image is on page 2. Tick checkbox.
    find("#tile_#{ @me.images.last.key } .tile-select").set(true)

    images = Image.count

    click_button 'Delete'
    page.should have_content('Image(s) deleted.')

    Image.count.should eq(images - 1)
  end

  after(:each) do
    logout(:user)
    Warden.test_reset!
  end
end