class AddProductCategoryToProducts < ActiveRecord::Migration[5.0]
  def change
    add_reference :products, :product_categories, index: true
  end
end
