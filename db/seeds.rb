# rails db:seed

require 'faker'

Product.delete_all

5.times do
  Product.create name: Faker::Commerce.product_name, code: Faker::Code.npi
end
