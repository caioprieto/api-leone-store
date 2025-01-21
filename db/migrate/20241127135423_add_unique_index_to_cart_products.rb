class AddUniqueIndexToCartProducts < ActiveRecord::Migration[7.0]
  def change
    add_index :cart_products, [:cart_id, :product_id], unique: true, name: "unique_cart_product_index"
  end
end
