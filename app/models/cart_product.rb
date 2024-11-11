class CartProduct < ApplicationRecord
  belongs_to :cart, class_name: '::Cart'
  belongs_to :product, class_name: '::Product'
end
