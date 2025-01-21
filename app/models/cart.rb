class Cart < ApplicationRecord
  belongs_to :user, class_name: '::User', optional: true

  has_many :cart_products, class_name: '::CartProduct', dependent: :destroy
  has_many :products, through: :cart_products
  has_one :order, class_name: '::Order'

  accepts_nested_attributes_for :cart_products, allow_destroy: true

  def save_products(product_and_quantity)
    ActiveRecord::Base.transaction do
      product_and_quantity.each do |product_id, quantity|
        cart_product = cart_products.find_or_initialize_by(product_id: product_id)
        cart_product.update!(quantidade_produto_carrinho: quantity)
      end

      remove_product_without_quantity
      calculate_subtotal
    end
  end

  def calculate_subtotal
    value_total = 0

    products.each do |product|
      value_total += product.preço_final * cart_products.find_by(product_id: product.id).quantidade_produto_carrinho
    end

    update_column(:subtotal, value_total)
  end

  private

  def remove_product_without_quantity
    cart_products.where(quantidade_produto_carrinho: 0).destroy_all
  end
end
