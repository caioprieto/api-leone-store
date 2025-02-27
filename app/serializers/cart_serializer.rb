class CartSerializer < ActiveModel::Serializer
  attributes :id, :status, :cupom_value, :subtotal, :total

  belongs_to :user
  belongs_to :cupom

  # has_many :cart_products
  has_many :cart_products_formatted, key: :cart_products

  def cart_products_formatted
    object.cart_products.order(:id)
  end
end
