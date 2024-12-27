class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :code, :active, :quantity, :description, :size_description, :preço_final
end
