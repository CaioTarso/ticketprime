class AddQrCodeToOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_column :order_items, :qr_code, :string
  end
end
