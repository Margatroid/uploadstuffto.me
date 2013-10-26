require 'spec_helper'

describe 'deletion', :type => :feature do
  before(:each) do
    @me = create(:user_with_images)
    login_as(@me, :scope => :user)
  end

  it 'lets you delete an image' do
  end

  it 'lets you delete multiple images' do
  end

  after(:each) do
    logout(:user)
    Warden.test_reset!
  end
end