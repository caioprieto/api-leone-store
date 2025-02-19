class CreateCupoms < ActiveRecord::Migration[7.0]
  def change
    create_table :cupoms do |t|
      t.string :name, null: false
      t.datetime :start_date, null: false
      t.datetime :final_date, null: false
      t.decimal :desconto, null: false, default: 0.0
      t.boolean :active, default: true, null: false

      t.timestamps
    end
  end
end
