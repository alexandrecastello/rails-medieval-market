class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy trade]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @products = Product.all

    if params[:query].present?
      @products = @products.global_search(params[:query])
    end
  end

  def show
    @order = Order.new
  end

  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params)
    @product.user = current_user
    @product.save
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end 
  end

  def edit
  end

  def update
    @product.update(product_params)
    @product.save
    redirect_to product_path(@product)
  end

  def destroy # rever se queremos que o usuário posso deletar produtos
    @product.destroy
    redirect_to products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
  
  def product_params
    params.require(:product).permit(:name, :description, :quantity, :category, :coin_price, :tradable_for)
  end
  
end
