class CreateOrderedProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :ordered_products do |t|
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.string :product_name
      t.decimal :product_price
      t.string :product_color
      t.numeric :quantity

      t.timestamps
    end
  end
end
