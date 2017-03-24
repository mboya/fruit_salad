class AddFieldToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :quantity, :integer
  end
end
