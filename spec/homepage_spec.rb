require 'spec_helper'

describe 'homepage', :type => :feature do
  it "loads a page with the site's name" do
    visit '/'
    expect(page).to have_content 'No more ideas'
  end
end
