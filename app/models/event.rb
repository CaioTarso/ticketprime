class Event < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_one_attached :image
  belongs_to :user

  validates :name, :category, :date, :price, :tickets_available, presence: true
  validates :tickets_available, numericality: { greater_than_or_equal_to: 0 }

  def tickets_sold
    order_items.sum(:quantity)
  end

  def revenue
    order_items.sum('quantity') * price
  end
end
