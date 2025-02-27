class Api::UsersController < ApplicationController
  before_action :set_user, only: %i[list_orders details cart_active]

  def create
    @user = ::User.create(user_params)

    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}, status: :ok
    else
      render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def login
    @user = ::User.find_by(username: user_params[:username])

    if @user && @user.authenticate(user_params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}, status: :ok
    else
      render json: {error: 'Úsuario ou senha inválidos'}, status: :unprocessable_entity
    end
  end

  def list_orders
    return render json: { message: 'Você precisa estar logado' }, status: :unprocessable_entity if @user.blank?

    user_orders = @user.orders

    render json: user_orders, status: :ok
  end

  def details
    return render json: { message: 'Você precisa estar logado' }, status: :unprocessable_entity if @user.blank?

    render json: @user, status: :ok
  end

  def cart_active
    return render json: { error: "Não tem carrinho ativo" } if @user.try(:cart).blank?

    render json: @user.cart, status: :ok, serializer: CartSerializer
  end

  private

  def user_params
    params.permit(:username, :password)
  end
end
