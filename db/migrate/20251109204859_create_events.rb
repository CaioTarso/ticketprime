class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :category
      t.datetime :date
      t.decimal :price
      t.integer :tickets_available
      t.text :description

      t.timestamps
    end
  end
end
