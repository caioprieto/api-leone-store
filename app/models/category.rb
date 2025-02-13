class Category < ApplicationRecord
  has_many :products

  scope :find_category, lambda { |name, id|
    return where(id: id) if id.present?
    return if name.blank?

    where('name ILIKE ?', "%#{name}%")
  }
end
