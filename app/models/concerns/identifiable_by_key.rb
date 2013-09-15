module IdentifiableByKey
  extend ActiveSupport::Concern

  included do
    before_validation :add_key
  end

  private

  def add_key
    return unless self.key.nil?
    self.key = loop do
      tmp = SecureRandom.urlsafe_base64(4, false)
      break tmp unless self.class.where(key: tmp).exists?
    end
  end
end