class UsersController < ApplicationController
 
  before_action :set_user, only: %i[show my_items edit update ]

  def show
    @products = @user.products
  end
  
  def my_items
    # check set_user method
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "user updated"
    else
      render :edit
    end
  end

  # def create
  #   @user = User.new(use_params)

  #   if @user.save
  #     redirect_to @user, notice: 'Welcome'
  #   else
  #     render :new, notice: 'Please review pending fields'
  #   end
  # end

  # def destroy
  #   @user.destroy
  # end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :avatar, :coins, :username)
  end
 
end
