class Admin::UsersController < AdminController
  include ApplicationHelper

  layout false, only: :show

  before_action :load_user, only: [:show, :destroy]

  def index
    @q = User.ransack params[:q]
    @users = @q.result
      .order(created_at: :desc).page(params[:page])
      .per Settings.per_page
    @ord = get_index params[:page], Settings.per_page
  end

  def show
  end

  def destroy
    if @user.destroy
      flash.now[:success] = t "delete_success"
    end
    redirect_to admin_users_path
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      render file: "public/404.html", status: :not_found, layout: true
    end
  end
end
