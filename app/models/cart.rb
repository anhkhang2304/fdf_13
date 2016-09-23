class Cart
  class << self
    def init_cart current_order
      current_order.detail_orders.select_product
    end
  end
end
