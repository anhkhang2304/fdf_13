class DetailOrdersController < ClientController
  protect_from_forgery except: :create

  before_action :authenticate_login!

  def create
    @order = current_order
    @order.user_id = current_user.id
    get_order_item
    if @order.save!
      session[:order_id] = @order.id
      redirect_to products_path
    else
      flash[:danger] = t "can_not_update"
      redirect_to products_path
    end
  end

  private
  def detail_order_params
    params.require(:detail_order).permit :quantity, :product_id
  end

  def get_order_item
    @order_item = @order.detail_orders
      .find_by product_id: params[:detail_order][:product_id]
    @order_item = @order_item.nil? ? new_item : update_item
  end

  def update_item
    quantity = params[:detail_order][:quantity].to_i + @order_item.quantity
    @order_item.update_attributes! quantity: quantity
  end

  def new_item
    @order_item = @order.detail_orders.new detail_order_params
    @order_item.set_price
  end
end
