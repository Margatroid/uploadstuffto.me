module IdentifiableByKey
  extend ActiveSupport::Concern

  included do
    before_create :add_key
  end

  protected

  def add_key
    p "\nAdding key\n"
    self.key = loop do
      tmp = SecureRandom.urlsafe_base64(4, false)
      break tmp unless self.class.where(key: tmp).exists?
    end
  end
end