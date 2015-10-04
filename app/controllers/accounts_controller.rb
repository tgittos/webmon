class AccountsController < ApplicationController

  def register
    redirect_to sites_path if session[:user]
  end

  def create
    app_uid = params[:app_host][:auid]
    user_email = params[:user][:email]
    Rails.logger.info "app_uid: #{app_uid}"
    Rails.logger.info "user_email: #{user_email}"
    session[:user] = User.find_or_create_by(email: user_email, app_uid: app_uid) 
    if !session[:user].nil?
      render json: { status: "ok" }
    else
      render json: { status: "error" }
    end
  end

end
