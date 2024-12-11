class Api::CartsController < ApplicationController
  before_action :set_cart, only: %i[show update]

  def create
    product_and_quantity = cart_params[:cart_products_attributes].pluck(:product_id, :quantidade_produto_carrinho)

    return if product_and_quantity.blank?

    @cart = Cart.new

    if @cart.save
      @cart.save_products(product_and_quantity)

      render json: @cart, status: :created, serializer: CartSerializer
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def update
    product_and_quantity = cart_params[:cart_products_attributes].pluck(:product_id, :quantidade_produto_carrinho)

    return if product_and_quantity.blank?

    if @cart.save
      @cart.save_products(product_and_quantity)

      render json: @cart, status: :ok, serializer: CartSerializer
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @cart, serializer: CartSerializer
  end

  private

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



# Exemplo JSON
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
