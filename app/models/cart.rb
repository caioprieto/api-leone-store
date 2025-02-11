class Cart < ApplicationRecord
  belongs_to :user, class_name: '::User', optional: true

  has_many :cart_products, class_name: '::CartProduct', dependent: :destroy
  has_many :products, through: :cart_products
  has_one :order, class_name: '::Order'

  accepts_nested_attributes_for :cart_products, allow_destroy: true

  before_validation :calculate_values
  before_validation :remove_product_without_quantity

  def add_products(product_and_quantity)
    invalid_product_ids = product_and_quantity.map(&:first) - Product.where(id: product_and_quantity.map(&:first)).pluck(:id)

    unless invalid_product_ids.empty?
      errors.add(:base, "Os seguintes produtos não existem: #{invalid_product_ids.join(', ')}")
      return false
    end

    set_product_and_quantity(product_and_quantity)
    true
  end

  private

  def set_product_and_quantity(product_and_quantity)
    product_and_quantity.each do |product_id, quantity|
      cart_product = cart_products.find_or_initialize_by(product_id: product_id)
      cart_product.update!(quantidade_produto_carrinho: quantity)
    end
  end

  def calculate_values
    calculate_subtotal
  end

  def calculate_subtotal
    value_total = 0

    cart_products.each do |cart_product|
      value_total += cart_product.product.preço_final * cart_product.quantidade_produto_carrinho
    end

    self.subtotal = value_total
  end

  def remove_product_without_quantity
    cart_products.where(quantidade_produto_carrinho: 0).destroy_all
  end
end
