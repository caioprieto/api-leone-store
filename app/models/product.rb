class Product < ApplicationRecord
  validates :name, :code, presence: true

  scope :order_by_name, -> { order(:id) }
end
