class CreateProductSizes < ActiveRecord::Migration[7.0]
  def change
    create_table :product_sizes do |t|
      t.belongs_to :product, foreign_key: true
      t.string :size, null: false
      t.integer :quantity, null: false, default: 0
    end
  end
end
