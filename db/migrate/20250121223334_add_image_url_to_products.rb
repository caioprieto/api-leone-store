class AddImageUrlToProducts < ActiveRecord::Migration[7.0]
  def change
    change_table :products do |t|
      t.string :image_url
    end
  end
end
