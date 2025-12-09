class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(created_at: :desc).includes(:order_items)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
