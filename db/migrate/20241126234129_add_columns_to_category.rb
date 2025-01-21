class AddColumnsToCategory < ActiveRecord::Migration[7.0]
  def change
    change_table :categories do |t|
      t.boolean :active_view_index
    end
  end
end
