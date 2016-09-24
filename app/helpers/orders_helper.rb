module OrdersHelper

  def current_order
    session[:order_id].present? ? Order.find(session[:order_id]) : Order.new
  end

  def send_message orders
    ChatWork.api_key = "b9c2ebdfd7d124e28235dca47d78649f"
    name = ChatWork::Me.get["name"]
    account_id = ChatWork::Me.get["account_id"]
    room_id = ChatWork::Me.get["room_id"]
    message_body = "[To:#{account_id}] #{name}\nWe have new order!\n"
    orders.detail_orders.select_product.each do |item|
      message_body += "Product:  #{item.name} "
      message_body += "Quantity: #{item.quantity} "
      message_body += "Price: #{item.price} \n"
      message_body += "Total money: #{item.total_money} \n"
    end
    ChatWork::Message.create room_id: room_id, body: message_body
  end
end
