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
    @product.name = @product.name.capitalize
    @product.category = @product.category.capitalize
    @product.tradable_for = @product.tradable_for.capitalize
    existing_product = current_user.products.find_by name: @product.name
    if existing_product
      redirect_to edit_product_path(existing_product), alert: "You already have #{existing_product.name}. If you want to add more, please add on product edition page"
    else
      @product.save
      if @product.save
        redirect_to product_path(@product), notice: 'Product created'
      else
        render :new
      end
    end 
  end

  def edit
  end

  def update
    @product.update(product_params)
    @product.name = @product.name.capitalize
    @product.category = @product.category.capitalize
    @product.tradable_for = @product.tradable_for.capitalize
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
    params.require(:product).permit(:name, :description, :quantity, :category, :coin_price, :tradable_for, :photo)
  end
  
end
