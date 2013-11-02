class Album < ActiveRecord::Base
  validates :user_id, presence: true

  belongs_to :user
  has_many :album_images, -> { order('position DESC') }, :dependent => :destroy
  has_many :images, through: :album_images

  include IdentifiableByKey

  def add_images(current_user, image_ids)
    begin
      ActiveRecord::Base.transaction do
        images = current_user.images.find(image_ids)

        images.each do |image|
          self.album_images.create(:image_id => image.id)
        end
      end
      true
    rescue ActiveRecord::RecordNotFound => exception
      false
    end
  end

  def has_images?
    self.album_images.count > 0
  end

  def to_param
    key
  end
end
