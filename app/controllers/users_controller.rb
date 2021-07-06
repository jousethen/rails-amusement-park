class UsersController < ApplicationController
skip_before_action :require_login, only: [:new, :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    
    if user.authenticate(params[:user][:password])
      user.save
      session[:user_id] = user.id

      if user.admin
        session[:admin] = user.id
      end
      
      redirect_to user_path(user.id)
    else
      redirect_to new_user_path
    end
  end



  private 

  def user_params
    params.require(:user).permit(:name, :height, :happiness, :nausea, :tickets, :password, :admin)
  end

  

end
