class AddInviteIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invite_id, :integer
    add_foreign_key :users, :invites
  end
end
