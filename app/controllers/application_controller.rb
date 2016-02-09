class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from "ActionController::InvalidAuthenticityToken" do |exception|
    redirect_to cookies_path
  end
  
  def ensure_logged_in
    if session[:user].nil?
      redirect_to root_path
    else
      @user = User.find(session[:user]["id"])
    end
  end

end
