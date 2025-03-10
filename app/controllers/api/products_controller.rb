class Api::ProductsController < ApplicationController

  # {
  #   "name": "Cropped Laís",
  #   "code": "333",
  #   "active": true,
  #   "quantity": 10,
  #   "description": "nadadaa",
  #   "preço_final": 200,
  #   "product_sizes_attributes": [
  #     { "size": "P", "quantity": 2 },
  #     { "size": "M", "quantity": 3 },
  #     { "size": "G", "quantity": 3 }
  #   ],
  #   "product_colors_attributes": [
  #     { "color_id": 1, "quantity": 2 },
  #     { "color_id": 2, "quantity": 2 }
  #   ]
  # }

  before_action :set_product, only: %i[show update destroy upload_image delete_image]
  before_action :set_admin, only: [:create, :update, :destroy, :upload_image, :delete_image]
  before_action :verify_admin, only: [:create, :update, :destroy, :upload_image, :delete_image]

  def index
    @products = Product.search_name(params[:name])
                       .search_code(params[:code])
                       .search_category(params[:category])
                       .preload(:colors, :product_colors, :product_sizes)

    render json: @products
  end

  def show
    render json: @product
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: api_product_url(@product)
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
  end

  def upload_image
    if params[:image].blank?
      return render json: { error: 'Precisa enviar uma imagem!' }
    end

    @product.image.attach(params[:image])

    if @product.image.attached?
      image_url = url_for(@product.image)

      @product.update(image_url: image_url)

      render json: { message: 'Imagem salva com sucesso!', image_url: image_url }, status: :created
    else
      render json: { error: 'Falhou ao salvar a imagem!' }, status: :unprocessable_entity
    end
  end

  def delete_image
    return if @product.image.blank?

    @product.image.destroy

    render json: { message: 'Imagem excluída com sucesso!' }
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name, :code, :preço_final, :category_id, :quantity, :active,
      product_sizes_attributes: %i[id size quantity _destroy],
      product_colors_attributes: %i[id color_id quantity _destroy]
    )
  end
end
