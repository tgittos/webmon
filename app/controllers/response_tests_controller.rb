class ResponseTestsController < ApplicationController
  
  before_action :ensure_logged_in
  before_action :set_site
  before_action :set_response_test, only: [:show, :edit, :update, :destroy, :results]

  def new
    @test = ResponseTest.new
  end

  def create
    @test = ResponseTest.new(response_test_params)
    @site.tests << @test

    if @test.save
      flash[:notice] = "Response test has been created."
      redirect_to [@site, @test]
    else
      flash.now[:alert] = "Response test has not been created."
      render "new"
    end
  end

  def show
  end

  def destroy
    @test.destroy
    flash[:notice] = "Response test has been deleted."
    redirect_to site_path(@site)
  end

  def results
    respond_to do |format|
      format.csv do
        results = @test.test_results.partition(&:result)
        data = ["status,population",
                "Passed,#{results.first.count}",
                "Failed,#{results.last.count}"].join("\n")
        render text: data
      end
    end
  end

  private

  def set_site
    @site = Site.find(params[:site_id])
  end

  def set_response_test
    @test = @site.tests.find(params[:id])
  end

  def response_test_params
    params.require(:response_test).permit(:comparison, :content)
  end

end
