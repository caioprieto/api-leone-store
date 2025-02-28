class ProductSize < ApplicationRecord
  belongs_to :product, class_name: '::Product', inverse_of: :product_sizes
end
