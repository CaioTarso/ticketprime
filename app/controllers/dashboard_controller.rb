class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = current_user.events.includes(:order_items)
    
    @total_tickets_sold = @events.sum(&:tickets_sold)
    @total_revenue = @events.sum(&:revenue)
  end
end
