class Order < ApplicationRecord
  belongs_to :cart, class_name: "::Cart"
  belongs_to :address, optional: true, class_name: "::Address"

  before_validation :duplicate_order_cart_id, on: :create

  private

  def duplicate_order_cart_id
    tem_pedido = ::Cart.find_by(id: self.cart_id).order.id.present?

    if tem_pedido
      errors.add(:cart, "Já tem pedido pra esse carrinho")
    end
    true
  end
end

# state_machine :status, initial: :pendente do
#   state :pendente
#   state :confirmado
#   state :enviado
#   state :entregue
#   state :cancelado

#   event :confirmar do
#     transition pendente: :confirmado
#   end

#   event :enviar do
#     transition confirmado: :enviado
#   end

#   event :entregar do
#     transition enviado: :entregue
#   end

#   event :estornar do
#     transition confirmado: :pendente
#   end

#   event :cancelar do
#     transition [:pendente, :confirmado] => :cancelado
#   end

#   after_transition on: :confirmar, do: :notificar_cliente
#   after_transition to: :enviado, do: :gerar_rastreamento
# end

# def notificar_cliente
#   debugger
# end
