class SitesController < ApplicationController

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
    @site = Site.find(params[:id])
  end

  private

  def site_params
    params.require(:site).permit(:name, :url)
  end

end
