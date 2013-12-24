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

  it 'shows the user that uploaded this public image' do
    path_to_uploader =
      Rails.application.routes.url_helpers.user_path(@image.user)

    @image.public  = true

    render
    rendered.should have_text(@image.user.username)
    rendered.should have_selector("a[href='#{ path_to_uploader }']")
  end

  it 'will not link to uploader if image is private' do
    path_to_uploader =
      Rails.application.routes.url_helpers.user_path(@image.user)

    @image.public  = false

    render
    rendered.should_not have_text(@image.user.username)
    rendered.should_not have_selector("a[href='#{ path_to_uploader }']")
  end

  it 'link to uploader if uploader is looking at their own private image' do
    view.stub(:user_signed_in?).and_return(true)
    view.stub(:current_user).and_return(@image.user)

    path_to_uploader =
      Rails.application.routes.url_helpers.user_path(@image.user)

    @image.public  = false

    render
    rendered.should have_text(@image.user.username)
    rendered.should have_selector("a[href='#{ path_to_uploader }']")
  end
end
