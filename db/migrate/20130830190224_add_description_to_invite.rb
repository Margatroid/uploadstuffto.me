class AddDescriptionToInvite < ActiveRecord::Migration
  def change
    add_column :invites, :description, :text
  end
end
