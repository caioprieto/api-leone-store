class AddActiveOrderToUsers < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:users, :active_order_id)
      add_column :users, :active_order_id, :integer
    end
  end
end
