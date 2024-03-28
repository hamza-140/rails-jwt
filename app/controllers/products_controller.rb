class ProductsController < ApplicationController
	before_action :authenticate_request

  def index
    @products = @current_user.products
    render json: @products
  end


  def show
    @product = Product.find(params[:id])
    render json: @product
  end
  def edit
    @product = Product.find(params[:id])
    if @product.user_id != @current_user.id
      render json: { error: 'Not authorized to edit this product' }, status: :unauthorized
    else
      render json: @product
    end
  end

  def create
    Rails.logger.debug("Incoming request parameters: #{params.inspect}")

    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  rescue ActionController::ParameterMissing => e
    render json: { error: "Bad Request: Missing required parameters. Please provide the necessary parameters: #{e.param}" }, status: :bad_request
  rescue StandardError => e
    Rails.logger.error("Unexpected error in ProductsController#create: #{e.message}")
    render json: { error: " Something went wrong" }, status: :internal_server_error
  end


  private
   def product_params
      params.require(:product).permit(:name,:price,:user_id)
    end


end
