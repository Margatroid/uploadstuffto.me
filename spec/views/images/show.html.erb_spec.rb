require 'spec_helper'

describe "images/show" do
  before(:each) do
    @image = assign(:image, stub_model(Image))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end

  it 'shows the user that uploaded this image' do
    uploader = create(:user)
    @image.user = uploader
    render
    rendered.should have_text(uploader.username)
  end
end
