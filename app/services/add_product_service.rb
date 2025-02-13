class AddProductService
  def initialize(products)
    products.each do |product|
      existing_product = Product.find_by(code: "#{product['code']}")

      return if existing_product

      params = {
        name: "#{product['name']}",
        code: "#{product['code']}",
        preço_final: "#{product['preço_final']}"
      }

      Product.create!(attributes: params, category_id: Category.last.id)
    end
  end
end
