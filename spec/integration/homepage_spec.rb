require 'spec_helper'

describe 'homepage behaviour', :type => :feature do
  before { visit '/' }
  it "loads a page with the site's name" do
    expect(page).to have_content 'No more ideas'
  end

  it 'will display an upload field if logged in' do
  end

  it 'will not display an upload field if logged out' do
  end
end
