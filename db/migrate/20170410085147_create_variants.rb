class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.integer :variant_inid
      t.string :sku
      t.decimal :cost_price, precision: 8, scale: 2
      t.decimal :price, precision: 8, scale: 2
      t.integer :quantity
      t.decimal :weight
      t.string :opt_title
      t.integer :product_id
      t.integer :supplier_id

      t.timestamps null: false
    end
    add_index :variants, :variant_inid
    add_index :variants, :sku
  end
end
