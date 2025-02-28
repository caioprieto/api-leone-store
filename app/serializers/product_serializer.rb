class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :code, :active, :quantity, :description, :size_description, :preço_final, :image_url

  has_many :product_sizes, key: :sizes
  has_many :product_colors, key: :colors
end
