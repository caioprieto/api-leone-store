class Order < ApplicationRecord
  include StateMachines::OrderState

  belongs_to :cart, class_name: "::Cart"
  belongs_to :user, class_name: "::User"
  belongs_to :address, optional: true, class_name: "::Address"

  validate :cart_uniq, on: :create

  def address_present?
    address.present?
  end

  private

  def cart_uniq
    return errors.add(:cart, "Já tem pedido pra esse carrinho") if ::Order.where(cart_id: self.cart_id).first.present?
    true
  end
end
