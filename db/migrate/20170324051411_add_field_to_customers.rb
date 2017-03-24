class AddFieldToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :external_id, :string
    add_column :customers, :step, :integer
  end
end
