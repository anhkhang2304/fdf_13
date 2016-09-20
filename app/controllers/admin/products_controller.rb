class Admin::ProductsController < AdminController
  include ApplicationHelper

  layout false, only: [:new, :edit, :show]

  before_action :load_categories, except: [:index, :destroy]
  before_action :load_product, except: [:index, :create, :new]

  def index
    @q = Product.ransack params[:q]
    @products = @q.result
      .includes(:comments).order(created_at: :desc)
      .page(params[:page]).per Settings.per_page
    @ord = get_index params[:page], Settings.per_page
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t "add_success"
    else
      flash[:danger] = t "add_fail"
    end
    redirect_to admin_products_path
  end

  def edit
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t "update_success"
    end
    redirect_to admin_products_path
  end

  def destroy
    if @product.destroy
      flash.now[:success] = t "delete_success"
    else
      flash.now[:danger] = t "product.can_not_delete"
    end
    redirect_to admin_products_path
  end

  private
  def product_params
    params.require(:product)
      .permit :name, :description, :price, :avatar, :category_id, :remove_avatar
  end

  def load_categories
    @categories = Category.all
  end

  def load_product
    @product = Product.find_by id: params[:id]
    if @product.nil?
      render file: "public/404.html", status: :not_found, layout: true
    end
  end
end
