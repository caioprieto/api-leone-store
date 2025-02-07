class Api::AdminsController < ApplicationController
  def create
    @admin = ::Admin.create(admin_params)

    if @admin.valid?
      token = encode_token({admin_id: @admin.id})
      render json: {admin: @admin, token: token}, status: :ok
    else
      render json: {error: 'Úsuario ou senha inválidos'}, status: :unprocessable_entity
    end
  end

  def login
    @admin = ::Admin.find_by(username: admin_params[:username])

    if @admin && @admin.authenticate(admin_params[:password])
      token = encode_token({admin_id: @admin.id})
      render json: {admin: @admin, token: token}, status: :ok
    else
      render json: {error: 'Úsuario ou senha inválidos'}, status: :unprocessable_entity
    end
  end

  private

  def admin_params
    params.permit(:username, :password)
  end
end
