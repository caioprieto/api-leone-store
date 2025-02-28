class Api::OrdersController < ApplicationController
  # {
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

  before_action :set_order, only: [:update, :show, :confirmar]
  before_action :set_cart, only: [:create]
  before_action :set_user, only: [:active_order]
  before_action :verify_user, only: [:create, :update, :show]

  def index
    @orders = Order.all

    render json: @orders, status: :ok
  end

  def create
    @order = Order.new(cart: @cart, user: @user)

    if @order.save
      render json: @order, status: :ok
    else
      render json: { error: @order.errors.full_messages }, status: :unprocessable_entity
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

  def active_order
    return render json: { error: "Não tem pedido ativo" } if @user.try(:active_order).blank?

    render json: @user.active_order, status: :ok
  end

  # POST /api/orders/ID/confirmar
  def confirmar
    return if @order.status == 'confirmado'

    if @order.confirmar
      render json: @order, status: :ok
    else
      render json: { error: 'Problemas na hora de confirmar, verifique as informações de Endereço e Pagamento' }, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def set_cart
    return if params[:cart_id].blank?

    @cart = Cart.find_by(id: params[:cart_id])
  end

  def address_params
    params.require(:address).permit(:street, :cep, :state, :city, :bairro, :complemento, :number)
  end
end
