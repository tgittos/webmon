class AccountsController < ApplicationController

  def register
    if session["user"] && !User.where(id: session["user"]["id"]).empty?
      redirect_to sites_path
    else
      render(:layout => "layouts/blank")
    end
  end

  def create
    app_uid = params[:app_host][:auid]
    user_email = params[:user][:email]
    user = User.find_or_create_by(email: user_email, app_uid: app_uid) 
    user.send_emails = true
    user.save
    session["user"] = user
    if !session["user"].nil?
      render json: { status: "ok" }
    else
      render json: { status: "error" }
    end
  end

end
