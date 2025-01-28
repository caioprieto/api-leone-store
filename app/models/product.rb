class Product < ApplicationRecord
  belongs_to :category

  has_one_attached :image
  has_many :cart_products, class_name: '::CartProduct', dependent: :destroy

  validates :name, :code, :preço_final, presence: true

  scope :search, -> (term) { where('LOWER(name) LIKE ?', "%#{term.downcase}%") if term.present? }
  scope :order_by_name, -> { order(:id) }
end
