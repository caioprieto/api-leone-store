class ProductColor < ApplicationRecord
  belongs_to :product, class_name: '::Product'
  belongs_to :color, class_name: '::Color'

  with_options allow_nil: true, prefix: true do
    delegate :name, to: :color
  end
end
