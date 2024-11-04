class PortionsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])

    @portion = @product.portions.build
  end
end