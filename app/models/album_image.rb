class AlbumImage < ActiveRecord::Base
  belongs_to :album
  acts_as_list scope: :album
  has_one :image

  validates :album_id, presence: true
  validates :image_id, presence: true
end
