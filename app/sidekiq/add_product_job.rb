class AddProductJob
  include Sidekiq::Job

  def perform(products)
    products.each do |product|
      code = "#{product['code']}"
      name = "#{product['name']}"
      existing_product = Product.find_by(code: code)

      unless existing_product
        Product.create(name: name, category_id: "#{product['category_id']}", code: code, preço_final: "#{product['preço_final']}")
        message(name)
      end
    end
  end

  def message(name)
    exclamação = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

    puts "#{exclamação}#{exclamação} #{name} #{exclamação}#{exclamação}"
  end
end
