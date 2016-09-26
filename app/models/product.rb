class Product < ActiveRecord::Base
  scope :where_contains, -> keyword {where("name like ?","%#{keyword}%")}

  mount_uploader :avatar, AvatarUploader
  belongs_to :category
  has_many :comments
  has_many :detail_orders

  validates :name, presence: true, uniqueness:true, length: {maximum: 50}
  validates :quantity, numericality: true, allow_nil: true
  validates :price, numericality: true, allow_blank: true
  validates :category_id, presence: true
  validate :image_size_validation

  ratyrate_rateable "rate"

  private
  def image_size_validation
    if avatar.size > Settings.avatar.bytes_image
      errors.add "avatar_size:", I18n.t("product.image_size_error")
    end
  end
end
