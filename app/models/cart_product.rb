class CartProduct < ApplicationRecord
  belongs_to :cart, class_name: '::Cart'
  belongs_to :product, class_name: '::Product'

  with_options allow_nil: true, prefix: true do
    delegate :name, :active, :code, to: :product
  end

  validates :product_id, uniqueness: { scope: :cart_id }
end
