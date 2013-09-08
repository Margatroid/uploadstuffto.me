class Image < ActiveRecord::Base
  belongs_to :user

  attr_accessible :file
  has_attached_file :file
end
