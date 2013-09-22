class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  belongs_to :invite
  has_many :images
  validates :invite_id, presence: true
  validates :username, presence: true
  validates_format_of :username, :with => /\A(\w|-)+\Z/i,
    :message => '- only alphanumerics, underscores and hyphens are allowed.
      No spaces.'

  def recently_uploaded(limit = 10)
    self.images.order('created_at DESC').limit(limit)
  end
end
