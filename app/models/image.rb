class Image < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :file, :attachment_presence => true
  validates :key, presence: true

  before_create :set_file_name

  has_attached_file :file,
    :styles => { :thumb => '200x200#' },
    :convert_options => { :thumb => '-quality 75 -strip' },
    :path => 'public/:style/:basename:extension',
    :url => '/:style/:basename:extension'

  include IdentifiableByKey

  def self.recently_uploaded(current_user = nil, limit = 30)
    if current_user
      where("user_id != #{ current_user.id }").order('created_at DESC').limit(limit)
    else
      self.all.order('created_at DESC').limit(limit)
    end
  end

  def to_param
    key
  end

  private

  def set_file_name
    extension = File.extname(file_file_name).downcase
    self.file.instance_write(:file_name, "#{ self.key }.#{ extension }")
  end
end
