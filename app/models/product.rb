class Product < ApplicationRecord
  belongs_to :category
  belongs_to :cart, optional: true

  validates :name, :code, presence: true

  scope :search, -> (term) { where('LOWER(name) LIKE ?', "%#{term.downcase}%") if term.present? }
  scope :order_by_name, -> { order(:id) }
end
