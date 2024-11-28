class CartProductSerializer < ActiveModel::Serializer
  attributes :product_id, :product_name, :product_active, :product_code, :quantidade_produto_carrinho, :product_preço_final
end
