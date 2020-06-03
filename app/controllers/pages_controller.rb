class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home products]
  def home
    @products = Product.all.size > 15 ? Product.all[-15..Product.all.size] : Product.all
  end
end
