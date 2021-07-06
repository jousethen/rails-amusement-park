class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new

  end

  def create
    user = User.find_by(name: params[:user][:name])

    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      redirect_to '/signin'
    end
  end

  def destroy
    session.delete :user_id
  end

end