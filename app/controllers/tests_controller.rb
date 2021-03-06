class TestsController < ApplicationController
  
  before_action :ensure_logged_in
  before_action :set_site
  before_action :set_content_test, only: [:show, :edit, :update, :destroy, :results]

  def new
    @test = Test.new
  end

  def create
    @test = @site.tests.build(test_params)

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

  def destroy
    @test.destroy
    flash[:notice] = "Content test has been deleted."
    redirect_to site_path(@site)
  end

  #def results
  #  respond_to do |format|
  #    format.csv do
  #      results = @test.test_statuses.partition(&:result)
  #      data = ["status,population",
  #              "Passed,#{results.first.count}",
  #              "Failed,#{results.last.count}"].join("\n")
  #      render text: data
  #    end
  #  end
  #end

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
