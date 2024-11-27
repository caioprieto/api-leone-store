class User < ApplicationRecord
  has_secure_password
  has_many :carts, class_name: '::Cart'
end
