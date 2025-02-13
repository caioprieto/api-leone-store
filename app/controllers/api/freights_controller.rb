class Api::FreightsController < ApplicationController
  def calculate
    service = CalculateFreightService.new(
      params[:cep_to],
      params[:height],
      params[:width],
      params[:length],
      params[:weight]
    )

    result = service.call
    format_result = FreightViewModel.new(result).formatted

    render json: format_result, status: :ok
  end
end
