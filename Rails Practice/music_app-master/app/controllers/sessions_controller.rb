class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:email], user_params[:password])
    unless @user
      render :new
    else
      login!(@user)
    end
  end

  def destroy
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
