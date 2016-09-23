class ClientController < ApplicationController

  protect_from_forgery with: :exception
  layout "client"

  def authenticate_login!
    redirect_to new_user_session_path unless current_user
  end
end
