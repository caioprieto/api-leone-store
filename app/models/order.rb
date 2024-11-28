class Order < ApplicationRecord
  belongs_to :cart, class_name: "::Cart"
  belongs_to :address, optional: true, class_name: "::Address"

  # validate :duplicate_order_cart_id, on: :create

  def duplicate_order_cart_id
    if cart.orders.present?
      errors.add(:cart, "Já tem pedido pra esse carrinho")
    end
  end
end
