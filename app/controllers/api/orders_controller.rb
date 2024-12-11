class Api::OrdersController < ApplicationController
  before_action :set_order, only: [:update, :show]
  before_action :authorize, only: [:update, :show]

  def create
    cart = Cart.find_by(id: params[:cart_id])

    return if cart.blank?

    order = Order.new(cart: cart)

    if order.save
      render json: order, status: :ok
    else
      render json: { error: 'Carrinho já tem pedido' }, status: :unprocessable_entity
    end
  end

  def update
    if address_params.present?
      if @order.address
        @order.address.update(attributes: address_params)
      else
        @order.create_address!(address_params)
      end
    end

    @order.save

    render json: @order, status: :ok, serializer: OrderSerializer
  end

  def show
    render json: @order, status: :ok, serializer: OrderSerializer
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:street, :cep, :state, :city, :bairro, :complemento, :number)
  end
end

# Exemplo JSON
# {
#   "cart_id": 1,
#   "address": {
#     "street": "Rua A",
#     "city": "São Paulo",
#     "state": "SP",
#     "cep": "12321312",
# 		"bairro": "Jardim Candida",
# 		"number": 1234,
# 		"complemento": "Apartamento 21-c"
#   }
# }