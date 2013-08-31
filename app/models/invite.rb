class Invite < ActiveRecord::Base
  validates :description, presence: true
  validates :key,         length:   { minimum: 16 }, uniqueness: true

  after_initialize :set_defaults

  private
  def set_defaults
    self.key         ||= SecureRandom.base64
    self.reuse_times ||= 0
  end
end
