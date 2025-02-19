class CartSerializer < ActiveModel::Serializer
  attributes :id, :status, :cupom_value, :subtotal, :total

  belongs_to :user
  belongs_to :cupom

  has_many :cart_products
end
