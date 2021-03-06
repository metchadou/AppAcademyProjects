class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  def login_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    return nil if session[:session_token].nil?

    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def logged_in?
    !!current_user
  end

end
