class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :login!, :logged_in?

  def current_user
    @cu ||= User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    @user.reset_session_token!
    session[:session_token] = @user.session_token
    redirect_to user_url(@user)
  end

  def logged_in?
    !!current_user
  end

  def must_be_logged_in
    unless logged_in?
      redirect_to new_session_url
    end
  end

end
