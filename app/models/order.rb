class Order < ApplicationRecord
  include StateMachines::OrderState

  belongs_to :cart, class_name: "::Cart"
  belongs_to :user, class_name: "::User"
  belongs_to :address, optional: true, class_name: "::Address"

  validates :cart_id, uniqueness: { message: "já está associado a um pedido" }

  def address_present?
    address.present?
  end
end
