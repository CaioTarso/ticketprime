class CartsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_cart

  

  def show
    @cart = current_user.cart || current_user.create_cart!
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

  def increase
    cart = current_user.cart
    item = cart.cart_items.find_by(event_id: params[:event_id])

    item.update(quantity: item.quantity + 1) if item

    redirect_to cart_path
  end

  def decrease
    cart = current_user.cart
    item = cart.cart_items.find_by(event_id: params[:event_id])

    if item
      if item.quantity > 1
        item.update(quantity: item.quantity - 1)
      else
        item.destroy
      end
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
  cart_items = cart.cart_items.includes(:event)

  order = nil   

  ActiveRecord::Base.transaction do
    order = current_user.orders.create!

    cart_items.each do |item|
      OrderItem.create!(
        order: order,
        event: item.event,
        quantity: item.quantity,
        price: item.event.price
      )

      item.event.update!(tickets_available: item.event.tickets_available - item.quantity)
    end

    cart.cart_items.destroy_all
  end

  redirect_to order_path(order), notice: "Compra realizada com sucesso!"
end




  def set_cart
    @cart = current_user.cart || current_user.create_cart! 
  end
end
