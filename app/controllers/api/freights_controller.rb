class Api::FreightsController < ApplicationController
  # {
  #   "cep_to": "13603012",
  #   "height": 10.0,
  #   "width": 10.0,
  #   "length": 10.0,
  #   "weight": 10.0
  # }

  def calculate
    service = CalculateFreightService.new(
      params[:cep_to],
      params[:cart_id]
    )

    result = service.call
    format_result = FreightViewModel.new(result).formatted

    render json: format_result, status: :ok
  end
end
