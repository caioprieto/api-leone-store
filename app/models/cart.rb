class Cart < ApplicationRecord
  has_many :cart_products, class_name: '::CartProduct', dependent: :destroy
  has_many :products, through: :cart_products

  belongs_to :user, class_name: '::User', optional: true

  accepts_nested_attributes_for :cart_products, allow_destroy: true

  before_validation :remove_product_without_quantity

  def save_products(product_and_quantity)
    product_and_quantity.each do |product_id, quantity|
      product_exist = cart_products.find_by(product_id: product_id)

      if product_exist
        product_exist.update(quantidade_produto_carrinho: quantity)
      else
        cart_products.create(product_id: product_id, quantidade_produto_carrinho: quantity)
      end
    end

    remove_product_without_quantity
    calculate_total
  end

  def calculate_total
    value_total = 0

    products.each do |product|
      value_total += product.preço_final * cart_products.find_by(product_id: product.id).quantidade_produto_carrinho
    end

    update_column(:total, value_total)
  end

  private

  def remove_product_without_quantity
    cart_products.where(quantidade_produto_carrinho: 0).destroy_all
  end
end
