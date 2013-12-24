require 'spec_helper'

describe "images/show" do
  before(:each) do
    @image = assign(:image, stub_model(Image))
    @image.user = create(:user)
    @permissions = {}
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end

  it 'shows the user that uploaded this image' do
    uploader = create(:user)
    path_to_uploader =
      Rails.application.routes.url_helpers.user_path(uploader)

    @image.public  = true
    @image.user = uploader

    render
    rendered.should have_text(uploader.username)
    rendered.should have_selector("a[href='#{ path_to_uploader }']")
  end

  it 'will not link to uploader if image is private' do
    uploader = create(:user)
    path_to_uploader =
      Rails.application.routes.url_helpers.user_path(uploader)

    @image.public  = false
    @image.user = uploader

    render
    rendered.should_not have_text(uploader.username)
    rendered.should_not have_selector("a[href='#{ path_to_uploader }']")
  end
end
