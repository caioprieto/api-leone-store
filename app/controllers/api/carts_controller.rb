class Api::CartsController < ApplicationController
  before_action :set_cart, only: :show

  def show
    render json: @cart
  end

  def set_cart
    @cart = ::Cart.where(id: params[:id])
  end
end
