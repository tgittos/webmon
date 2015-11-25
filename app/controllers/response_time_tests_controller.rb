class ResponseTimeTestsController < ApplicationController
  
  before_action :ensure_logged_in
  before_action :set_site
  before_action :set_response_time_test, only: [:show, :edit, :update, :destroy, :results]

  def new
    @test = ResponseTimeTest.new
  end

  def create
    @test = ResponseTimeTest.new(response_time_test_params)
    @site.tests << @test

    if @test.save
      flash[:notice] = "Response time test has been created."
      redirect_to [@site, @test]
    else
      flash.now[:alert] = "Response time test has not been created."
      render "new"
    end
  end

  def show
  end

  def destroy
    @test.destroy
    flash[:notice] = "Response time test has been deleted."
    redirect_to site_path(@site)
  end

  def results
    respond_to do |format|
      format.tsv do
        data = ["date\tresponse"].concat(@test.test_results.newest_first.limit(100).collect do |sh|
          "#{sh.created_at.strftime("%Y-%m-%d-%H:%M")}\t#{sh.value}"
        end).join("\n")
        render text: data
      end
    end
  end

  private

  def set_site
    @site = @user.sites.find(params[:site_id])
  end

  def set_response_time_test
    @test = @site.tests.find(params[:id])
  end

  def response_time_test_params
    params.require(:response_time_test).permit(:comparison, :content, :failure_threshold, :clear_threshold)
  end

end
