class Api::CategoryProductsController < ApplicationController
  def index
    scope = Category.find_category(params[:category_name], params[:category_id])&.first.products
    search = params[:search]
    resource_collection = scope.order(Arel.sql("preço_final #{search[:order_preço_final]}"))

    if resource_collection
      render json: resource_collection, status: :ok
    else
      render json: { error: 'Categoria não foi encontrada' }, status: :not_found
    end
  end
end
