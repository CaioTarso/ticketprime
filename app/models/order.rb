class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  def total
    order_items.sum("quantity * price")
  end
end