class User < ApplicationRecord
  has_secure_password

  has_many :carts, class_name: '::Cart'
  has_many :orders, class_name: '::Order'

  validates :password, length: { minimum: 8, message: 'precisa ter 8 caracteres' }
  validates_uniqueness_of :username, message: 'já está em uso'
end
