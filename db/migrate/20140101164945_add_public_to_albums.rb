class AddPublicToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :public, :boolean, :default => false
    Album.update_all(:public => false)
  end
end
