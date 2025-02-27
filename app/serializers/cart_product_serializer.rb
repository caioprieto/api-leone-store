class CartProductSerializer < ActiveModel::Serializer
  attributes :product_id, :product_name, :quantidade_produto_carrinho, :product_preço_final
end
