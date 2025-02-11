class SincronizaProductJob
  include Sidekiq::Job
  require 'json'

  def perform
    AddProductJob.perform_async(new_products)
  end

  def new_products
    file_path = Rails.root.join('config', 'products_mock.json')
    file = File.read(file_path)

    JSON.parse(file)
  end
end
