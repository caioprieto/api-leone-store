class CartSerializer < ActiveModel::Serializer
  attributes :id, :total, :subtotal

  has_many :cart_products
end
