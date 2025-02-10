class ProductJob
  include Sidekiq::Job
  require 'json'

  def perform
    products.each do |product|
      name = "#{product['name']}"
      category_id = "#{product['category_id']}"
      code = "#{product['code']}"
      price_final = "#{product['price_final']}"

      existing_product = Product.find_by(code: code)

      unless existing_product
        Product.create(name: name, category_id: category_id, code: code, preço_final: price_final)
      end
    end
  end

  def products
    file_path = Rails.root.join('config', 'products_mock.json')
    file = File.read(file_path)

    JSON.parse(file)
  end
end
