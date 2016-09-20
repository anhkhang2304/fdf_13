class Category < ActiveRecord::Base
  scope :where_contains, -> keyword {where("title like ?","%#{keyword}%")}

  has_many :products

  validates :title, uniqueness: true, presence: true, length: {maximum: 100}
  validates :description, length: {maximum: 200}

  def verify_destroy_category
    if self.products.any?
      errors.add "category", I18n.t("category.can_not_delete")
    end
  end
end
