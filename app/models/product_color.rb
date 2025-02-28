class ProductColor < ApplicationRecord
  belongs_to :product, class_name: '::Product'
  belongs_to :color, class_name: '::Product'
end
