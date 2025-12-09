class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :event

  before_create :generate_qr_code_value

  private

  def generate_qr_code_value
    self.qr_code ||= SecureRandom.uuid
  end
end
