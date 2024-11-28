class AddColumnsToProducts < ActiveRecord::Migration[7.0]
  def change
    change_table :products do |t|
      t.decimal :preço_desconto
      t.decimal :preço_custo
      t.decimal :preço_final
    end
  end
end
