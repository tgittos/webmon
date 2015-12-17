class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def ensure_logged_in
    session["user"] = User.first
    redirect_to root_path unless session[:user]
    @user = User.find(session["user"]["id"])
  end

end
