class Cart < ApplicationRecord
  has_many :cart_products, class_name: '::CartProduct', dependent: :destroy
  has_many :products, through: :cart_products

  accepts_nested_attributes_for :cart_products, allow_destroy: true

  # Adicionar UM ou MAIS produtos - Sempre passar como STRING os IDS
  def add_products(product_ids)
    ids = product_ids.split(',')

    ids.each do |product_id|
      cart_products.create(product_id: product_id)
    end
  end

  # Remove UM ou MAIS produtos - Sempre passar como STRING os IDS
  def remove_products(product_ids)
    ids = product_ids.split(',')

    return if ids.blank?

    ids.each do |product_id|
      products.where(id: product_id).last.destroy
    end
  end
end
