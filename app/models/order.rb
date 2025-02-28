class Order < ApplicationRecord
  include StateMachines::OrderState

  belongs_to :cart, class_name: "::Cart"
  belongs_to :user, class_name: "::User"
  belongs_to :address, optional: true, class_name: "::Address"

  validates :cart_id, uniqueness: { message: "já está associado a um pedido" }

  after_save :set_values

  def address_present?
    address.present?
  end

  private

  def set_values
    cart.update(user: user)
    user.update(active_order_id: id)
  end
end
