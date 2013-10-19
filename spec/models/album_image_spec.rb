require 'spec_helper'

describe AlbumImage do
  it 'must be destroyed if an image is deleted' do
    user = create(:user_with_image)
    user.albums.create.album_images.create(:image_id => Image.first.id)

    AlbumImage.count.should eq(1)
    # Destroying a user destroys all his images
    user.destroy
    AlbumImage.count.should eq(0)
  end
end
