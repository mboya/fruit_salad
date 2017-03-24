class ChangeCustomerExternalId < ActiveRecord::Migration[5.0]
  def change
    change_column :customers, :external_id, :string
  end
end
