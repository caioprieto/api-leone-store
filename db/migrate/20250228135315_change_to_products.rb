class ChangeToProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :size
    remove_column :products, :color

    add_column :products, :height, :decimal
    add_column :products, :width, :decimal
    add_column :products, :length, :decimal
    add_column :products, :weight, :decimal
  end
end
