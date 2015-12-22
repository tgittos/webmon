class AccountsController < ApplicationController

  protect_from_forgery :except => [:create]

  def register
    if session[:user] && !User.where(id: session[:user]["id"]).empty?
      redirect_to sites_path
    else
      render(:layout => "layouts/blank")
    end
  end

  def create
    app_uid = params[:app_host][:auid]
    user_email = params[:user][:email]
    user = User.find_by(email: user_email, app_uid: app_uid) || User.create(email: user_email, app_uid: app_uid)
    session[:user] = user
    if !session[:user].nil?
      render json: { status: "ok" }
    else
      render json: { status: "error" }
    end
  end

end
