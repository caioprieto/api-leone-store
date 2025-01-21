class AddQuantidadeProdutoCarrinhoToCartProducts < ActiveRecord::Migration[7.0]
  def change
    change_table :cart_products do |t|
      t.integer :quantidade_produto_carrinho
    end
  end
end
