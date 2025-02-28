class CreateProductColors < ActiveRecord::Migration[7.0]
  def change
    create_table :product_colors do |t|
      t.belongs_to :product, foreign_key: true, null: false
      t.belongs_to :color, foreign_key: true, null: false
      t.integer :quantity, null: false
    end
  end
end
