class Cart < ApplicationRecord
  has_many :cart_products, class_name: '::CartProduct', dependent: :destroy
  has_many :products, through: :cart_products

  # Adicionar UM ou MAIS produtos - Sempre passar como STRING os IDS
  def add_products(product_ids)
    ids = product_ids.split(',')

    ids.each do |product_id|
      if ::Product.where(id: product_id).present?
        check_duplicate_product(product_id)
      else
        puts "=> NÃO EXISTE O PRODUTO COM ID=#{product_id}"
      end
    end
  end

  private

  def check_duplicate_product(product_id)
    return if products.exists?(id: product_id)

    cart_products.create!(product_id: product_id)
  end
end
