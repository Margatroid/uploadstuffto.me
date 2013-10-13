class CreateAlbumImages < ActiveRecord::Migration
  def change
    create_table :album_images do |t|
      t.text :description

      t.timestamps
    end
  end
end
