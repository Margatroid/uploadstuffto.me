require 'spec_helper'

describe "albums/edit" do
  # We'll be editing an album with two images.
  before(:each) do
    @album = assign(:album, stub_model(Album,
      :title => "MyString",
      :key => "YourString"
    ))

    @user = create(:user_with_images)

    @user.images.first(2).each do |image|
      @album.album_images.create(image_id: image.id)
    end
  end

  it "renders the edit album form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", album_path(@album), "post" do
      assert_select "input#album_title[name=?]", "album[title]"
    end
  end

  it 'renders each image in the album along with description fields' do
    render

    @user.images.first(2).each_with_index do |image, index|
      assert_select "img[src='/thumb/#{ image.key }.jpg']"
      assert_select "textarea[name='album[album_images_attributes][#{ index }][description]']"
    end
  end

  it 'renders the public/private checkbox' do
    render
    expect(rendered).to have_selector('input[name="album[public]"]')
  end
end
