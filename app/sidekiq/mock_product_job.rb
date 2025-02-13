class MockProductJob
  include Sidekiq::Job

  def perform
    file_path = Rails.root.join('config', 'products_mock.json')

    products = JSON.parse(File.read(file_path))

    new_product = {
      "name" => "Produto #{Time.now.to_i}",
      "code" => rand(3000..4000),
      "preço_final" => rand(100..1000)
    }

    products << new_product

    File.write(file_path, JSON.pretty_generate(products))
  end
end
