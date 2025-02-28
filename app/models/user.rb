class User < ApplicationRecord
  has_secure_password

  has_one :cart, -> { where(status: 'pending') }, class_name: '::Cart'
  has_one :active_order, class_name: '::Order'

  has_many :orders, class_name: '::Order'

  validates :password, length: { minimum: 8, message: 'precisa ter 8 caracteres' }
  validates_uniqueness_of :username, message: 'já está em uso'
end
