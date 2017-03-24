# require 'faker'

# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)


# 5.times do 
#   pc = ProductCategory.create name: Faker::Beer.name 
#   5.times do
#     Product.create name: Faker::Beer.malts, product_categories_id: pc.id
#   end
# end

5.times do
  Vendor.create name: Faker::Name.first_name, location: Faker::Address.city, price: Faker::Commerce.price
end 