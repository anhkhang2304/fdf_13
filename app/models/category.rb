class Category < ActiveRecord::Base
  has_many :products

  validates :title, uniqueness: true, presence: true, length: {maximum: 100}
  validates :description, length: {maximum: 200}
end
