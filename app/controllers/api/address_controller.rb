class Api::AddressController < ApplicationController
  include HTTParty

  def search
    postal_code = params[:postal_code]

    url = "https://viacep.com.br/ws/#{postal_code}/json/"
    response = HTTParty.get(url)

    if response.success?
      render json: response.parsed_response
    else
      render json: { error: 'CEP não encontrado' }, status: :not_found
    end
  end
end
