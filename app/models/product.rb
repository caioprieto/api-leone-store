class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  with_options allow_nil: true, prefix: true do
    delegate :name, to: :category
  end

  has_many :product_sizes, class_name: '::ProductSize', dependent: :destroy, inverse_of: :product
  has_many :product_colors, class_name: '::ProductColor', dependent: :destroy
  has_many :colors, through: :product_colors

  has_many :cart_products, class_name: '::CartProduct', dependent: :destroy
  has_many :carts, through: :cart_products

  accepts_nested_attributes_for :product_sizes, allow_destroy: true
  accepts_nested_attributes_for :product_colors, allow_destroy: true

  validates :name, :code, :preço_final, presence: true
  validates_uniqueness_of :code, message: 'já está em uso'

  scope :search_name, -> (term) { where('LOWER(name) LIKE ?', "%#{term.downcase}%") if term.present? }

  scope :search_code, lambda { |code|
    return if code.blank?

    where(code: code.to_s)
  }

  scope :search_category, lambda { |category|
    return if category.blank?

    joins(:category).where(categories: { name: category })
  }
end
