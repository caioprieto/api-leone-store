class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status

  belongs_to :cart
  belongs_to :address
end
