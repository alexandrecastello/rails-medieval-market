class OrdersController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    order = Order.new(order_params)
    order.user = current_user
    order.product = product
    price = product.coin_price * order.quantity
    if product.quantity < order.quantity
      flash[:alert] = "You can't buy this much #{product.name}"
      redirect_to products_path(product)
    else
      if price > current_user.coins
        flash[:alert] = "Not enough coins to buy this item."
        redirect_to products_path(product)
      else
        order.save
        current_user.coins -= price
        current_user.save
        product.user.coins += price
        product.user.save
        product.quantity -= order.quantity
        new_product = current_user.products.find_by name: product.name
        if new_product.nil?
          new_product = Product.new name: product.name, coin_price: product.coin_price, description: product.description, user: current_user
        else
          new_product.quantity += order.quantity
        end
        new_product.save
        product.save
        redirect_to user_path(current_user), notice: "Congratulations: It's yours. Now, please edit your new product price."
      end
    end
  end

  def trade
    seller_product = Product.find(params[:product_id])
    order = Order.new user: current_user, product: seller_product, quantity: 1, tradable: seller_product.tradable_for
    buyer_product = current_user.products.find_by name: order.tradable

    if seller_product.quantity <= 0
      flash[:alert] = "There is no #{seller_product.name} available at the moment. :( "
      redirect_to products_path(seller_product)
    elsif buyer_product.quantity <= 0
      flash[:alert] = "You have no #{buyer_product.name} available at the moment. :( "
      redirect_to products_path(seller_product)
    else
      buyer_new_product = current_user.products.find_by name: seller_product.name
      if buyer_new_product.nil?
        buyer_new_product = Product.new name: seller_product.name, coin_price: seller_product.coin_price, description: seller_product.description, user: current_user, quantity: 1
      else
        buyer_new_product.quantity += 1
      end
      seller_new_product = seller_product.user.products.find_by name: buyer_product.name
      if seller_new_product.nil?
        seller_new_product = Product.new name: buyer_product.name, coin_price: buyer_product.coin_price, description: buyer_product.description, user: seller_product.user, quantity: 1
      else
        seller_new_product.quantity += 1
      end
      seller_product.quantity -= 1
      buyer_product.quantity -= 1
      seller_product.save
      seller_new_product.save
      buyer_product.save
      buyer_new_product.save
      redirect_to user_path(current_user), notice: "Trade was successful! Now, please edit your new product's price."
    end
  end

  def order_params
    params.require(:order).permit(:quantity)
  end
end
