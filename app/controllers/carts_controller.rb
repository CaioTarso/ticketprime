class CartsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_cart

  

  def show
    @cart = current_user.cart
    @items = @cart.cart_items.includes(:event)
  end

  def add
    cart = current_user.cart
    item = cart.cart_items.find_by(event_id: params[:event_id])

    if item
      item.update(quantity: item.quantity + 1)
    else
      cart.cart_items.create(event_id: params[:event_id], quantity: 1)
    end

    redirect_to cart_path
  end

  def remove
    cart = current_user.cart
    cart.cart_items.where(event_id: params[:event_id]).destroy_all
    redirect_to cart_path
  end

  def checkout
    cart = current_user.cart
    cart.cart_items.destroy_all # no próximo passo salvaremos como Purchase
    redirect_to root_path, notice: "Compra finalizada!"
  end

  def set_cart
    @cart = current_user.cart || current_user.create_cart! 
  end
end
