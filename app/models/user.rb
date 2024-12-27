class User < ApplicationRecord
  has_secure_password

  has_many :carts, class_name: '::Cart'
  has_many :orders, class_name: '::Order'
end
