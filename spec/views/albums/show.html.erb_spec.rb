require 'spec_helper'

describe "albums/show" do
  before(:each) do
    @album = assign(:album, stub_model(Album, title: "Title", key: 'abcde', user_id: 1))
  end

  context 'when logged in and viewing own album' do
    it 'links to album edit' do
      view.stub(:current_user).and_return(create(:user))
      render
      expect(rendered).to have_link('Edit', href: edit_album_path(@album.key))
    end
  end

  context 'when logged out' do
    it 'does not link to album edit' do
      view.stub(:current_user).and_return(nil)
      render
      expect(rendered).to_not have_link('Edit album', href: edit_album_path(@album.key))
    end
  end

  context 'when logged in but not viewing own album' do
    it 'does not link to album edit' do
      view.stub(:current_user).and_return({ user_id: 2 })
      render
      expect(rendered).to_not have_link('Edit album', href: edit_album_path(@album.key))
    end
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
  end

  it 'shows album image descriptions' do
    AlbumImage.any_instance.stub(:save).and_return(true)
    Album.any_instance.stub(:has_images?).and_return(true)
    @album.album_images = [
      stub_model(AlbumImage,  description: 'foo', album_id: 1, image: stub_model(Image, key: 'hello')),
      stub_model(AlbumImage,  description: 'bar', album_id: 1, image: stub_model(Image, key: 'world'))
    ]
    render
    expect(rendered).to match('foo')
    expect(rendered).to match('bar')
  end
end
