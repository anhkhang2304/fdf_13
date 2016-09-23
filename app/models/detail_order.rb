class DetailOrder < ActiveRecord::Base
  scope :select_product, -> do
    joins(:product).select "detail_orders.*", "products.name", "products.avatar"
  end

  belongs_to :order
  belongs_to :product

  def set_price
    self.price = self.product.price
  end
end
