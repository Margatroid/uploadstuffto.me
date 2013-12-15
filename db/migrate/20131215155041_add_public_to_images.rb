class AddPublicToImages < ActiveRecord::Migration
  def change
    add_column :images, :public, :boolean
  end
end
