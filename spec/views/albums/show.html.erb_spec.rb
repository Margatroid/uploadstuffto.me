require 'spec_helper'

describe "albums/show" do
  before(:each) do
    @album = assign(:album, stub_model(Album, title: "Title", key: 'abcde', user_id: 1))
  end

  context 'when logged in and viewing own album' do
    it 'links to album edit' do
      render
      expect(rendered).to have_link('Edit album', href: edit_album_path(@album.key))
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
end
