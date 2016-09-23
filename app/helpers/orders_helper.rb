module OrdersHelper

  def current_order
    session[:order_id].present? ? Order.find(session[:order_id]) : Order.new
  end
end
