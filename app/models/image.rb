class Image < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :file, :attachment_presence => true
  validates :key, presence: true

  has_attached_file :file,
    :styles => { :thumb => "200x200#" },
    :convert_options => { :thumb => "-quality 75 -strip" }

  include IdentifiableByKey

  def to_param
    key
  end
end
