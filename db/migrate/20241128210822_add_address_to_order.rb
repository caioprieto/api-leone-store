class AddAddressToOrder < ActiveRecord::Migration[7.0]
  def change
    change_table :orders do |t|
      t.references :address, foreign_key: true
    end
  end
end
