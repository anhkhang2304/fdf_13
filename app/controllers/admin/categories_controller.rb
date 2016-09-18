class Admin::CategoriesController < AdminController
  include ApplicationHelper

  layout false, only: [:new]

  def index
    @categories = Category.where_contains(params["keyword"]).includes(:products).
      order(created_at: :desc).page(params[:page]).per Settings.per_page
    @ord = get_index params[:page], Settings.per_page
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

  def destroy
  end

  private
  def category_params
    params.require(:category).permit :title, :description
  end
end
