class Album < ActiveRecord::Base
  validates :user_id, presence: true

  belongs_to :user
  has_many :album_images, -> { order('position DESC') }
end
