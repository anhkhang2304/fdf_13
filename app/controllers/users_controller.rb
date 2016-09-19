class UsersController < ApplicationController
  layout "client"

  before_action :load_user, only: :show

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
