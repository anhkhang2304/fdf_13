class UsersController < ApplicationController
  layout "client"

  before_action :load_user, only: :show

  def index
    @q = User.ransack params[:q]
    @users = @q.result
      .order(created_at: :desc).page(params[:page])
      .per Settings.per_page
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @users }
      format.json { render json: @users, status: 200, content_type: "text/json" }
    end
  end

  def show
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      render file: "public/404.html", status: :not_found, layout: true
    end
  end
end
