class AlbumImage < ActiveRecord::Base
  belongs_to :album
  belongs_to :image
  acts_as_list scope: :album

  validates :album_id, presence: true
  validates :image_id, presence: true
end
