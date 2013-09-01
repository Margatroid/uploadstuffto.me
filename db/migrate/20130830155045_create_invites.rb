class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :key
      t.integer :usage

      t.timestamps
    end
  end
end
