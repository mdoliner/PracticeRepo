class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user_name], params[:password])
    if @user
      log_in!(@user)
    else
      flash.now[:notices] = ["Username/Password Combination is Incorrect"]
      render :new
    end
  end

  def destroy
    @user.try(:reset_session_token!)
    session[:session_token] = nil
    redirect_to new_session_url
  end

end
