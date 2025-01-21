class AddCartToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :cart, foreign_key: true
  end
end
