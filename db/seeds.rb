# rails db:seed

require 'faker'

Product.delete_all

3.times do
  Category.create name: Faker::Commerce.material
end

5.times do
  Product.create name: Faker::Commerce.product_name, code: Faker::Code.npi, category_id: Category.first.id
end
