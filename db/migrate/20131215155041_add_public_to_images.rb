class AddPublicToImages < ActiveRecord::Migration
  def change
    add_column :images, :public, :boolean, :default => false
    Image.update_all(:public => false)
  end
end
