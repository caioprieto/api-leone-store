class CartSerializer < ActiveModel::Serializer
  attributes :id, :total, :subtotal

  belongs_to :user

  has_many :cart_products
end
