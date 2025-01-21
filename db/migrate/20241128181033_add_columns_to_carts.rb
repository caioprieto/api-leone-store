class AddColumnsToCarts < ActiveRecord::Migration[7.0]
  def change
    change_table :carts do |t|
      t.decimal :subtotal
      t.decimal :total
    end
  end
end
