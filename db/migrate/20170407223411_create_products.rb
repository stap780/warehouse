class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :inid
      t.string :sku
      t.string :title
      t.integer :qt
      t.decimal :cost_price, precision: 8, scale: 2
      t.decimal :price, precision: 8, scale: 2

      t.timestamps null: false
    end
    add_index :products, :inid
    add_index :products, :sku
    add_index :products, :title
  end
end
