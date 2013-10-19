class AddPositionToAlbumImage < ActiveRecord::Migration
  def change
    add_column :album_images, :position, :integer
  end
end
