require 'net/http'
require 'uri'
require 'json'

class CalculateFreightService
  API_URL = "https://sandbox.melhorenvio.com.br/api/v2/me/shipment/calculate".freeze

  def initialize(cep, height, width, length, weight)
    @cep_origem = "13603-012"
    @services_quantity = 2
    @cep = cep
    @height = height
    @width = width
    @length = length
    @weight = weight
  end

  def call
    response = make_request
    parse_response(response)
  end

  private

  def make_request
    uri = URI.parse(API_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path, header)
    request.body = body.to_json

    http.request(request)
  end

  def header
    {
      "Content-Type" => "application/json",
      "Accept" => "application/json",
      "User-Agent" => "caiohideki23@gmail.com",
      "Authorization" => "Bearer #{ENV['MELHOR_ENVIO_TOKEN']}"
    }
  end

  def body
    {
      "from": { "postal_code": @cep_origem },
      "to": { "postal_code": @cep },
      "package": [
        {
          "height": @height,
          "width": @width,
          "length": @length,
          "weight": @weight
        }
      ],
      "services": @services_quantity.to_s
    }
  end

  def parse_response(response)
    return { error: "API não teve retorno" } unless response.body

    parsed_body = JSON.parse(response.body)
    response.code.to_i == 200 ? parsed_body : { error: parsed_body }
  end
end
