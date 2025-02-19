class AddCupomToCart < ActiveRecord::Migration[7.0]
  def change
    add_reference :carts, :cupom, foreign_key: true
  end
end
