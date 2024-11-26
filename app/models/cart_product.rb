class CartProduct < ApplicationRecord
  belongs_to :cart, class_name: '::Cart'
  belongs_to :product, class_name: '::Product'

  delegate :name, to: :product, allow_nil: true, prefix: true

  validate :check_product, on: :create

  def check_product
    return false if product_id.blank?
    return false if ::Product.find_by(id: product_id).blank?

    true
  end
end
