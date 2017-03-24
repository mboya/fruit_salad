class AddFieldsToVendors < ActiveRecord::Migration[5.0]
  def change
    add_column :vendors, :name, :string
    add_column :vendors, :location, :string
    add_column :vendors, :price, :string
  end
end
