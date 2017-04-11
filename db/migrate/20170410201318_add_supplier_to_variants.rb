class AddSupplierToVariants < ActiveRecord::Migration
  def change
    add_column :variants, :supplier, :string
  end
end
