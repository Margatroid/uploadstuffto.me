class AddFeaturedToUser < ActiveRecord::Migration
  def change
    add_column :users, :featured, :boolean, default: false
  end
end
