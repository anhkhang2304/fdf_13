class ProductsController < ClientController
  def index
    if params["cate"].present? && params["cate"] != ""
      @products = Product.where(category_id: params["cate"]).
        where_contains(params["keyword"]).
        order(created_at: :desc).page(params[:page]).per Settings.per_page
    else
      @products = Product.where_contains(params["keyword"]).
      order(created_at: :desc).page(params[:page]).per Settings.per_page
    end
    @categories = Category.all
  end

  def show
    @product = Product.find_by id: params[:id]
    @comment = Comment.new product: @product
    @comments = @product.comments.order(created_at: :desc)
      .page(params[:page]).per Settings.per_page
    if @product.nil?
      render file: "public/404.html", status: :not_found, layout: true
    end
  end
end
