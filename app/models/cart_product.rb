class CartProduct < ApplicationRecord
  belongs_to :cart, class_name: '::Cart'
  belongs_to :product, class_name: '::Product', inverse_of: :cart_products

  with_options allow_nil: true, prefix: true do
    delegate :name, :active, :code, :preço_final, to: :product
  end

  validates :product_id, uniqueness: { scope: :cart_id }
end
