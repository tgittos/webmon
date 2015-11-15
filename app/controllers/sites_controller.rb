class SitesController < ApplicationController
  before_action :ensure_logged_in
  before_action :load_user, only: [:index, :create]
  before_action :load_site, only: [:show, :edit, :update, :destroy, :response_times]

  def index
    @sites = @user.sites.active
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    @user.sites << @site

    if @site.save && @user.save
      flash[:notice] = "Site has been created."
      redirect_to @site
    else
      flash.now[:alert] = "Site has not been created."
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @site.update(site_params)
      flash[:notice] = "Site has been updated."
      redirect_to @site
    else
      flash.now[:alert] = "Site has not been updated."
      render "edit"
    end
  end

  def destroy
    @site.destroy
    flash[:notice] = "Site has been deleted."
    redirect_to sites_path
  end

  private

  def site_params
    params.require(:site).permit(:name, :url)
  end

  def load_site
    @site = Site.find(params[:id])
  end

  def load_user
    Rails.logger.info "session: #{session["user"]}"
    @user = User.find(session["user"]["id"])
  end
  
end
