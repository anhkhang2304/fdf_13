class OrdersController < ClientController
  before_action :authenticate_login!
  before_action :load_order, except: [:index, :create]

  def index
    @orders = Order.where(user_id: current_user.id).order(date_update: :desc)
      .page(params[:page]).per Settings.per_page
    @ord = get_index params[:page], Settings.per_page
    @order = Order.new
  end

  def show
  end

  def create
    @order = Order.new
    @order.user_id = current_user.id
    if @order.save
      session[:order_id] = @order.id
      flash[:success] = t "add_success"
      redirect_to orders_path
    else
      flash[:success] = t "add_fail"
      redirect_to orders_path
    end
  end

  def edit
    session[:order_id] = @order.id
    redirect_to products_path
  end

  def update
    if params[:order][:status].present?
      case params[:order][:status]
      when "pendding"
        @order.update_attributes status: :pendding
        session[:order_id] = nil
        flash[:success] = t "order.pay_success"
      when "cancel"
        @order.update_attributes status: :cancel
        flash[:danger] = t "order.pay_cancel"
      else
        flash[:danger] = t "order.pay_fail"
      end
    else
      flash[:danger] = t "order.pay_fail"
    end
    redirect_to order_path @order.id
  end

  def destroy
    if @order.status == Order.statuses[:created] || Order.statuses[:cancel]
      @order.destroy
      session[:order_id] = nil
      flash[:success] = t "delete_success"
    else
      flash[:danger] = t "order.can_not_delete"
    end
    redirect_to orders_path
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
