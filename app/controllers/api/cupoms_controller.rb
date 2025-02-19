class Api::CupomsController < ApplicationController
  before_action :set_cupom, only: [:update]
  # before_action :verify_admin, only: [:index, :create]

  def index
    @cupoms = resource_class.all

    render json: @cupoms, status: :ok
  end

  def create
    @cupom = resource_class.new(cupom_params)

    if @cupom.save
      render json: @cupom, status: :ok
    else
      render json: { error: @cupom.errors.full_messages }, status: :error
    end
  end

  def update
    if @cupom.update(cupom_params)
      render json: @cupom, status: :ok
    else
      render json: @cupom.errors, status: :unprocessable_entity
    end
  end

  private

  def set_cupom
    @cupom = resource_class.find_by(id: params[:id])
  end

  def resource_class
    ::Cupom
  end

  def cupom_params
    params.require(:cupom).permit(:name, :start_date, :final_date, :desconto)
  end
end
