class Product < ActiveRecord::Base
  belongs_to :category
  has_many :comments
  has_many :detail_orders

  validates :name, presence: true, length: {maximum: 50}
  validates :quantity, numericality: true
  validates :price, numericality: true, allow_blank: true
end
