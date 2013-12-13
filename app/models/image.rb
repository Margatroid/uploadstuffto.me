class Image < ActiveRecord::Base
  belongs_to :user
  has_many :album_images, :dependent => :destroy
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
      result = joins(:user).where('user_id != ? AND featured = ?',
                                  current_user.id, true)
    else
      result = joins(:user).where(users: { featured: true })
    end

    result.order('created_at DESC').limit(limit)
  end

  def self.delete_by_ids(current_user, image_ids)
    return false unless current_user

    images = find(image_ids)
    images.each do |image|
      return false if image.user_id != current_user.id
    end

    images.each { |image| image.destroy }
    true
  end

  def is_owned_by_user?(user)
    self.user_id == user.id
  end

  def to_param
    key
  end

  def file_remote_url=(url)
    # Add protocol if it's missing.
    unless url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]
      url = "http://#{url}"
    end

    self.file = URI.parse(url)
    @file_remote_url = url
  end

  private

  def set_file_name
    extension = File.extname(file_file_name).downcase
    self.file.instance_write(:file_name, "#{ self.key }.#{ extension }")
  end
end
