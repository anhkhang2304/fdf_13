class DetailOrdersController < ClientController
  protect_from_forgery except: :create

  before_action :load_detail_order, only: [:update, :destroy]
  before_action :authenticate_login!, except: [:create]

  def create
    if current_user.present?
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
    else
      respond_to do |format|
        msg = {msg: "login", url: new_user_session_path}
        format.json {render json: msg}
      end
    end
  end

  def update
    if params["type_edit_product"].present? && params["type_edit_product"] == "add"
      update_item
      respond_to do |format|
        msg = {msg: "add",quantity: @order_item.quantity,
          price: @order_item.price}
        format.json {render json: msg}
      end
    end
    if params["type_edit_product"].present? && params["type_edit_product"] == "sub"
      if @order_item.quantity > 1
        update_sub_item
        respond_to do |format|
          msg = {msg: "sub",quantity: @order_item.quantity,
            price: @order_item.price}
          format.json {render json: msg}
        end
      else
        respond_to do |format|
          msg = {msg: "fail"}
          format.json {render json: msg}
        end
      end
    end
  end

  def destroy
    if @order_item.present?
      @order_item.destroy
      respond_to do |format|
        msg = {msg: "success"}
        format.json {render json: msg}
      end
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

  def update_sub_item
    if @order_item.quantity > 1
      quantity = @order_item.quantity - params[:detail_order][:quantity].to_i
      @order_item.update_attributes! quantity: quantity
    end
  end

  def new_item
    @order_item = @order.detail_orders.new detail_order_params
    @order_item.set_price
  end

  def load_detail_order
    @order_item = DetailOrder.find_by order_id: params[:order_id],
    product_id: params[:product_id]
  end
end
