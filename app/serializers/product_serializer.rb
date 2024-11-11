class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :code, :active, :quantity
end
