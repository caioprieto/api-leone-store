class AddressSerializer < ActiveModel::Serializer
  attributes :id, :street, :cep, :state, :city, :bairro, :complemento, :number
end
