class Invite < ActiveRecord::Base
  validates :description, presence: true

  after_initialize :generate_key

  private
  def generate_key
    self.key = SecureRandom.base64
  end
end
