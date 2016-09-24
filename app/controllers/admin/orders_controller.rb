class Admin::OrdersController < AdminController
  layout false, only: [:show]

  before_action :load_order, only: [:update]

  def index
    @q = Order.ransack params[:q]
    @orders = @q.result
      .includes(:user).order(date_update: :desc)
      .page(params[:page]).per Settings.per_page
    @ord = get_index params[:page], Settings.per_page
  end

  def show
    @order = Order.find_by id: params[:id]
    if @order.nil?
      render file: "public/404.html", status: :not_found, layout: true
    end
  end

  def update
    if params[:order][:status].present?
      case params[:order][:status]
      when "done"
        @order.update_attributes status: :done
        flash[:success] = t "order.done"
      when "cancel"
        @order.update_attributes status: :cancel
        flash[:danger] = t "order.pay_cancel"
      else
        flash[:danger] = t "order.pay_fail"
      end
    else
      flash[:danger] = t "order.pay_fail"
    end
    redirect_to admin_orders_path
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    if @order.nil?
      render file: "public/404.html", status: :not_found, layout: true
    end
  end
end
