class ApplicationController < ActionController::Base
  include ApplicationHelper
  include OrdersHelper

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_cart

  def initialize_cart
    @cart = Cart.init_cart current_order
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up do |user_params|
      user_params.permit :name, :email, :password,
        :password_confirmation
    end
    devise_parameter_sanitizer.permit :account_update do |user_params|
       user_params.permit :name, :email, :password, :birthday,
        :password_confirmation, :current_password, :mobile, :address
    end
  end
end
