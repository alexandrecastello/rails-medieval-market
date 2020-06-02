class UsersController < ApplicationController
 
  before_action :set_user, only: %i[show]


  def show
    # check set_user method
    @user = User.new

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(use_params)

    if @user.save
      redirect_to @user, notice: 'Welcome'
    else
      render :new, notice: 'Please review pending fields'
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :encrypted_password,:avatar)
  end
 
end
