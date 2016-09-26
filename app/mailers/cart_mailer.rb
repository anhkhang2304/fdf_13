class CartMailer < ApplicationMailer

  def new_cart (order)
    @order = order
    mail to: "nguyen.van.long@framgia.com", subject: "New order received"
  end
end
