class Event < ApplicationRecord
  has_many :tickets, dependent: :restrict_with_error
  has_one_attached :image

  validates :name, :category, :date, :price, :tickets_available, presence: true
  validates :tickets_available, numericality: { greater_than_or_equal_to: 0 }

  # total de ingressos vendidos via associação tickets
  def tickets_sold
    tickets.sum(:quantity)
  end

  # receita total (soma tickets.quantity * event.price) – para um evento específico
  def revenue
    tickets.sum('quantity') * price
  end
end
