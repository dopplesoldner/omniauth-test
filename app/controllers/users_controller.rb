class UsersController < ApplicationController  
  
  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
    @authorizations = @user.authorizations
  end
end
