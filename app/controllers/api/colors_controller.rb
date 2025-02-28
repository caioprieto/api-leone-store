class Api::ColorsController < ApplicationController
  before_action :set_color, only: [:update, :destroy]

  def index
    @colors = resource_class.all

    render json: @colors, status: :ok
  end

  def create
    @color = resource_class.new(colors_params)

    if @color.save
      render json: @color, status: :ok
    else
      render json: { error: @color.errors.full_messages }
    end
  end

  def update
    if @color.update(colors_params)
      render json: @color, status: :ok
    else
      render json: { error: @color.errors.full_messages }
    end
  end

  def destroy
    @color.destroy
  end

  private

  def resource_class
    ::Color
  end

  def set_color
    @color = resource_class.find_by(id: params[:id])

    if @color.nil?
      render json: { error: 'A cor não foi encontrada' }, status: :not_found
    end
  end

  def colors_params
    params.require(:color).permit(:id, :name, :rgb)
  end
end
