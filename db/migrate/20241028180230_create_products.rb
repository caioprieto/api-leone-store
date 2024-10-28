class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :barcode
      t.string :code, null: false
      t.string :size
      t.string :color

      t.text :description
      t.text :size_description

      t.boolean :active, default: true, null: false
      t.integer :quantity, default: 0, null: false

      t.timestamps
    end
  end
end
