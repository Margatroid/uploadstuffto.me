class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :key
      t.integer :reuse_times

      t.timestamps
    end
  end
end
