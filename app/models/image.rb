class Image < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :file, :attachment_presence => true
  validates :key, presence: true

  has_attached_file :file,
    :styles => { :thumb => "200x200#" },
    :convert_options => { :thumb => "-quality 75 -strip" }

  include IdentifiableByKey

  def recently_uploaded(limit = 30)
    if user_signed_in?
      self.find_by("userid != #{ current_user.id }")
        .order('created_at DESC').limit(limit)
    else
      self.all.order('created_at DESC').limit(limit)
    end
  end

  def to_param
    key
  end
end
