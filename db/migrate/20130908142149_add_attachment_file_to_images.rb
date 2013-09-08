class AddAttachmentFileToImages < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :images, :file
  end
end
