class Image < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :file, :attachment_presence => true

  has_attached_file :file

  include IdentifiableByKey
end
