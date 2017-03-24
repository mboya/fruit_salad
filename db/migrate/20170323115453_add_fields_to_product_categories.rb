class AddFieldsToProductCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :product_categories, :name, :string
  end
end
