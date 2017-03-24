class AddFieldsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :product, :string
    add_column :orders, :customer_id, :string
  end
end
