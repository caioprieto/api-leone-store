class Cart < ApplicationRecord
  has_many :cart_products, class_name: '::CartProduct', dependent: :destroy
  has_many :products, through: :cart_products

  accepts_nested_attributes_for :cart_products, allow_destroy: true

  def save_products(product_and_quantity)
    product_and_quantity.each do |product_id, quantity|
      product_exist = cart_products.where(product_id: product_id)

      return create_cart_products(product_id, quantity) if product_exist.blank?

      product_exist.last.update(quantidade_produto_carrinho: quantity)
    end
  end

  private

  def create_cart_products(product_id, quantity)
    cart_products.create(product_id: product_id, quantidade_produto_carrinho: quantity)
  end
end
