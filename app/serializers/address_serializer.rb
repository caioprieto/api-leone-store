class AddressSerializer < ActiveModel::Serializer
  attributes :id, :cep, :logradouro, :complemento, :bairro, :localidade, :uf, :estado, :ddd, :regiao
end
