class Product < ApplicationRecord
  validates :name, :code, presence: true
end
