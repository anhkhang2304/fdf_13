class ClientController < ApplicationController
  protect_from_forgery with: :exception
  layout "client"
end
