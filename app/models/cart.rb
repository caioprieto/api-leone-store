class Cart < ApplicationRecord
  has_many :products

  # def add_products(ids)
  #   products_to_add = Product.where(id: ids)

  #   self.products << products_to_add
  # end
end