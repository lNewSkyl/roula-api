class UsersController < ApplicationController
  before_action :find_user, except: %i[create index]

  def index
    @users = User.all
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:id, :username, :email)
  end

  def find_user
	  @user ||= User.find(params[:id])
  end

end 
