class AlbumImage < ActiveRecord::Base
  belongs_to :user
  has_one :image

  validates :album_id, presence: true
  validates :image_id, presence: true
end
