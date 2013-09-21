require 'spec_helper'

describe "images/show", :type => :feature do
  before(:each) do
    @image = assign(:image, stub_model(Image))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end

  it 'has a correct image' do
    img = page.first(:css, '#fullsize_image')
    visit img[:src]
    page.status_code.should be 200
  end
end
