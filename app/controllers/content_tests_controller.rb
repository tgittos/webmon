class ContentTestsController < ApplicationController

  before_action :set_site
  before_action :set_content_test, only: [:show, :edit, :update, :destroy]

  def new
    @test = ContentTest.new
  end

  def create
    @test = @site.content_tests.build(content_test_params)

    if @test.save
      flash[:notice] = "Content test has been created."
      redirect_to [@site, @test]
    else
      flash.now[:alert] = "Content test has not been created."
      render "new"
    end
  end

  def show
  end

  private

  def set_site
    @site = Site.find(params[:site_id])
  end

  def set_content_test
    @test = @site.content_tests.find(params[:id])
  end

  def content_test_params
    params.require(:content_test).permit(:comparison, :content)
  end

end
