class AddKeyToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :key, :string
  end
end
