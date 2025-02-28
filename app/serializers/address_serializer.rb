class AddressSerializer < ActiveModel::Serializer
  attributes :id, :cep, :complemento, :bairro, :city, :state, :street
end
