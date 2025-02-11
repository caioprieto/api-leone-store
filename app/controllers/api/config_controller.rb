class Api::ConfigController < ApplicationController
  def reload_products
    SincronizaProductJob.perform_async
    render json: { message: 'Produtos atualizados!' }, status: :ok
  end
end
