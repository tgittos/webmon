class SitesController < ApplicationController

  def index
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
      # nothing yet
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
