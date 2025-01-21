class RemoveCartIdFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :cart_id, :integer
  end
end
