class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  has_many :product_sizes, class_name: '::ProductSize', dependent: :destroy
  has_many :sizes, through: :product_sizes

  has_many :cart_products, class_name: '::CartProduct', dependent: :destroy
  has_many :carts, through: :cart_products

  accepts_nested_attributes_for :product_sizes, allow_destroy: true

  validates :name, :code, :preço_final, presence: true
  validates_uniqueness_of :code, message: 'já está em uso'

  scope :search, -> (term) { where('LOWER(name) LIKE ?', "%#{term.downcase}%") if term.present? }
  scope :order_by_name, -> { order(:id) }
end
