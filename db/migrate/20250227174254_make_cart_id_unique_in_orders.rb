class MakeCartIdUniqueInOrders < ActiveRecord::Migration[7.0]
  def change
    remove_index :orders, :cart_id if index_exists?(:orders, :cart_id)
    add_index :orders, :cart_id, unique: true
  end
end
