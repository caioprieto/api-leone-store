class Api::AddressController < ApplicationController
  include HTTParty

  def search
    postal_code = params[:postal_code]
    url = "https://viacep.com.br/ws/#{postal_code}/json/"

    response = HTTParty.get(url)
    formatted_response = build_response(response)

    if response.success?
      render json: formatted_response, status: :ok
    else
      render json: { error: 'CEP não encontrado' }, status: :not_found
    end
  end

  private

  def build_response(response)
    {
      cep: response['cep'],
      street: response['logradouro'],
      neighborhood: response['bairro'],
      city: response['localidade'],
      state: response['uf'],
      region: response['regiao'],
      ibge_code: response['ibge'],
      ddd: response['ddd']
    }
  end
end
