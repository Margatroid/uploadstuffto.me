class AddAssociationsToAlbumImage < ActiveRecord::Migration
  def change
    add_column :album_images, :album_id, :integer
    add_column :album_images, :image_id, :integer
  end
end
