class Admin::CategoriesController < AdminController
  include ApplicationHelper

  layout false, only: [:new, :edit, :show]

  before_action :load_category, except: [:index, :create, :new]

  def index
    @categories = Category.where_contains(params["keyword"]).includes(:products).
      order(created_at: :desc).page(params[:page]).per Settings.per_page
    @ord = get_index params[:page], Settings.per_page
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
      if @category.save
        flash[:success] = t "add_success"
      end
    redirect_to admin_categories_path
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "update_success"
    end
      redirect_to admin_categories_path
  end

  def destroy
    if @category.verify_destroy_category
      flash[:danger] = t "category.can_not_delete"
    else
      @category.destroy
      flash[:success] = t "delete_success"
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :title, :description
  end

  def load_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      render file: "public/404.html", status: :not_found, layout: true
    end
  end
end
