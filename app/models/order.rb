class Order < ApplicationRecord
  belongs_to :cart, class_name: "::Cart"
  belongs_to :user, class_name: "::User"
  belongs_to :address, optional: true, class_name: "::Address"

  # before_validation :duplicate_order_cart_id, on: :create

  state_machine :status, initial: :pending do
    state :pending
    state :confirmado
    state :enviado

    event :confirmar do
      transition pending: :confirmado
    end

    event :enviar do
      transition confirmado: :enviado
    end
  end

  private

  # def duplicate_order_cart_id
  #   tem_pedido = ::Cart.find_by(id: self.cart_id).order.id.present?

  #   if tem_pedido
  #     errors.add(:cart, "Já tem pedido pra esse carrinho")
  #   end
  #   true
  # end
end
