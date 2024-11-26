class Api::CartsController < ApplicationController
  before_action :set_cart, only: :show

  def create
    product_ids = cart_params[:cart_products_attributes].pluck(:product_id)

    if product_ids.blank?
      render json: { error: 'É necessário fornecer pelo menos um produto' }, status: :unprocessable_entity
      return
    end

    @cart = Cart.new

    if @cart.save
      @cart.add_products(product_ids.join(','))

      render json: @cart, include: { cart_products: { include: :product } }, status: :created, serializer: CartSerializer
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
    params.require(:cart).permit(cart_products_attributes: [:id, :product_id])
  end
end
