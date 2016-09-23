class OrdersController < ClientController
  before_action :authenticate_login!
  before_action :load_order, only: [:show, :edit]

  def index
    @orders = Order.where(user_id: current_user.id).order(date_update: :desc)
      .page(params[:page]).per Settings.per_page
    @ord = get_index params[:page], Settings.per_page
  end

  def show
  end

  def create
    @order = Order.new order_params
    if @order.save
      session[:order_id] = @order.id
      redirect_to order_path @order
    else
      redirect_to new_order_path
    end
  end

  def edit
    session[:order_id] = @order.id
    redirect_to root_path
  end

  private

  def order_params
    params.require(:order).permit user: current_user
  end

  def load_order
    @order = Order.find_by id: params[:id]
    if @order.nil?
      render file: "public/404.html", status: :not_found, layout: true
    end
  end
end
