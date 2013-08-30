class Invite < ActiveRecord::Base
  after_initialize :generate_key

  private
  def generate_key
    self.key = SecureRandom.base64(16)
  end
end
