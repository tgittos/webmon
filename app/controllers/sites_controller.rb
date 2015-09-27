class SitesController < ApplicationController
  before_action :load_site, only: [:show, :edit, :update, :destroy]

  def index
    @sites = Site.active
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)

    if @site.save
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

  private

  def site_params
    params.require(:site).permit(:name, :url)
  end

  def load_site
    @site = Site.find(params[:id])
  end

end
