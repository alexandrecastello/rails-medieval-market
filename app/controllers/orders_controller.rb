class OrdersController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    order = Order.new(order_params)
    order.user = current_user
    order.product = product
    if product.quantity < order.quantity 
      flash[:alert] = "You can't buy this much #{product.name}"
      redirect_to products_path(product)
    else
      if product.coin_price > current_user.coins
        flash[:alert] = "Not enough coins to buy this item."
        redirect_to products_path(product)
      else
        order.save
        current_user.coins -= product.coin_price
        current_user.save
        product.user.coins += product.coin_price
        product.user.save
        product.quantity -= order.quantity
        new_product = current_user.products.find_by name: product.name
        if new_product.nil? 
          new_product = Product.new name: product.name, coin_price: product.coin_price, description: product.description, user: current_user
        end
        new_product.quantity = order.quantity
        new_product.save
        product.save
        flash[:alert] = "Congratulations: You bought #{product.quantity} #{product.name}"
        redirect_to user_path(current_user)
      end
    end
  end

  def order_params
    params.require(:order).permit(:quantity)
  end
end
