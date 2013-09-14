class Image < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true

  has_attached_file :file
end
