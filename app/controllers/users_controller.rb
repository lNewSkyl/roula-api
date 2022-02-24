class UsersController < ApplicationController
  before_action :set_user, only: %i[ show  ]


  def index
    @users = User.all
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:id, :username, :email, :balance)
  end

  def set_user
    @user ||= User.find(params[:id])
    @products = Product.order(created_at: :ASC)  
  end
  

end 
