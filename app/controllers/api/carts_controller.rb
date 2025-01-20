class Api::CartsController < ApplicationController
  before_action :set_cart, only: %i[show update]
  before_action :authorized_user, only: %i[update create show]

  # POST /api/carts
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
  def create
    product_and_quantity = cart_params[:cart_products_attributes].pluck(:product_id, :quantidade_produto_carrinho)

    return if product_and_quantity.blank?

    @cart = @user ? Cart.new(user: @user) : Cart.new

    if @cart.save
      @cart.save_products(product_and_quantity)

      render json: @cart, status: :created, serializer: CartSerializer
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # PATCH /api/carts/ID
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
  def update
    product_and_quantity = cart_params[:cart_products_attributes].pluck(:product_id, :quantidade_produto_carrinho)

    return if product_and_quantity.blank?
    return verify_user_current if @cart.user != @user

    if @user.present? && @cart.user.blank?
      @cart.update(user: @user)
    end

    if @cart.save
      @cart.save_products(product_and_quantity)

      render json: @cart, status: :ok, serializer: CartSerializer
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # GET /api/carts/ID
  def show
    return verify_user_current if @cart.try(:user) != @user

    render json: @cart, serializer: CartSerializer
  end

  private

  def verify_user_current
    return render json: @cart if @cart.user.blank?

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
