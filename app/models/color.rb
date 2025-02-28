class Color < ApplicationRecord
  has_many :product_colors, class_name: '::ProductColor'
end
