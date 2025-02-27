class Api::CartsController < ApplicationController

    # {
    #   "cart": {
    #     "cart_products_attributes": [
    #       {
    #         "product_id": 1,
    #         "quantidade_produto_carrinho": 1
    #       },
    #       {
    #         "product_id": 2,
    #         "quantidade_produto_carrinho": 1
    #       }
    #     ]
    #   }
    # }

  before_action :set_cart, only: %i[show update add_cupom]
  before_action :set_cupom, only: %i[add_cupom]
  before_action :set_user, only: %i[update create show]

  # POST /api/carts
  def create
    @cart = resource_class.new(cart_params)

    if @cart.save
      render json: @cart, status: :created, serializer: CartSerializer
    else
      render json: { errors: @cart.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /api/carts/ID
  def update
    if @cart.update(cart_params)
      render json: @cart, status: :ok, serializer: CartSerializer
    else
      render json: { errors: @cart.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /api/carts/ID
  def show
    render json: @cart, serializer: CartSerializer
  end

  def add_cupom
    if @cart.update(cupom: @cupom)
      render json: @cart, status: :ok
    else
      render json: { errors: @cart.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def resource_class
    ::Cart
  end

  def set_cart
    @cart = Cart.find_by(id: params[:id])

    if @cart.nil?
      render json: { error: 'Carrinho não encontrado!' }, status: :not_found
    end
  end

  def set_cupom
    @cupom = ::Cupom.find_by(name: params[:cupom_name]).first

    if @cupom.nil?
      render json: { error: 'Cupom não encontrado!' }, status: :not_found
    end
  end

  def cart_params
    params.require(:cart).permit(cart_products_attributes: [:product_id, :quantidade_produto_carrinho])
  end
end
