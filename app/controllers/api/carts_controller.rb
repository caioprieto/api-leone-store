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

  before_action :set_cart, only: %i[show update]
  before_action :authorized_user, only: %i[update create show]

  # POST /api/carts
  def create
    product_and_quantity = cart_params[:cart_products_attributes].pluck(:product_id, :quantidade_produto_carrinho)
    return if product_and_quantity.blank?

    @cart = @user ? Cart.new(user: @user) : Cart.new

    if @cart.add_products(product_and_quantity) && @cart.save!
      render json: @cart, status: :created, serializer: CartSerializer
    else
      render json: { errors: @cart.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /api/carts/ID
  def update
    return error_user_current if @cart.try(:user) != @user && @cart.user.present?

    @cart.update(user: @user) if @user.present? && @cart.user.blank?

    product_and_quantity = cart_params[:cart_products_attributes].pluck(:product_id, :quantidade_produto_carrinho)

    return if product_and_quantity.blank?

    if @cart.add_products(product_and_quantity) && @cart.save!
      render json: @cart, status: :ok, serializer: CartSerializer
    else
      render json: { errors: @cart.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /api/carts/ID
  def show
    return error_user_current if @cart.try(:user) != @user && @cart.user.present?

    render json: @cart, serializer: CartSerializer
  end

  private

  def error_user_current
    render json: { error: 'Você só pode ver/alterar carrinhos que estão na sua conta!' }, status: :unauthorized
  end

  def set_cart
    @cart = Cart.find_by(id: params[:id])

    if @cart.nil?
      render json: { error: 'Carrinho não encontrado!' }, status: :not_found
    end
  end

  def cart_params
    params.require(:cart).permit(cart_products_attributes: [:id, :product_id, :quantidade_produto_carrinho])
  end
end
