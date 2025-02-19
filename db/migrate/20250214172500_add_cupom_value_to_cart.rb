class AddCupomValueToCart < ActiveRecord::Migration[7.0]
  def change
    change_table :carts do |t|
      t.decimal :cupom_value
    end
  end
end
