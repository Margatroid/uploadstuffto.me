class AddKeyToImages < ActiveRecord::Migration
  def change
    add_column :images, :key, :string
  end
end
