require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  before do
    @site = FactoryGirl.create(:site)
    [:content_test, :response_test, :response_time_test].each do |test_type|
      FactoryGirl.create(test_type, site: @site)
    end
  end

  describe "site_css_class" do

    it "returns ok when no tests have failed" do
      @site.tests.each {|t| t.test_results.destroy_all }
      @site.tests.each {|t| FactoryGirl.create(:test_result, test: t, result: true)}
      expect(site_css_class(@site)).to eq "ok"
    end

    it "returns warning when some tests have failed, but not all" do
      @site.tests.each {|t| t.test_results.destroy_all }
      @site.tests.each_with_index {|t, i| FactoryGirl.create(:test_result, test: t, result: i % 2 == 0 ? true : false)}
      expect(site_css_class(@site)).to eq "warning"
    end

    it "returns error when all tests have failed" do
      @site.tests.each {|t| t.test_results.destroy_all }
      @site.tests.each {|t| FactoryGirl.create(:test_result, test: t, result: false)}
      expect(site_css_class(@site)).to eq "error"
    end

  end

  describe "test_css_class" do

    it "returns ok when last test result passes" do
      5.times do |i|
        Timecop.freeze(i.minutes.ago) do
          FactoryGirl.create(:test_result, test: @site.tests.first, result: i == 0)
        end
      end
      expect(test_css_class(@site.tests.first)).to eq "ok"
    end

    it "returns error when last test result fails" do
      5.times do |i|
        Timecop.freeze(i.minutes.ago) do
          FactoryGirl.create(:test_result, test: @site.tests.first, result: i != 0)
        end
      end
      expect(test_css_class(@site.tests.first)).to eq "error"
    end

  end

  describe "test_result_css_class" do

    it "returns ok when result is true" do
      result = FactoryGirl.create(:test_result, test: @site.tests.first, result: true)
      expect(test_result_css_class(result)).to eq "ok"
    end

    it "returns error when result is false" do
      result = FactoryGirl.create(:test_result, test: @site.tests.first, result: false)
      expect(test_result_css_class(result)).to eq "error"
    end

  end

  describe "site_test_path" do

    it "returns appropriate URLs for each type of test" do

      content_test = FactoryGirl.create(:content_test, site: @site, content: "Not Foobar")
      expect(site_test_path(@site, content_test)).to match(/content_test/) 

      response_test = FactoryGirl.create(:response_test, site: @site, content: "500")
      expect(site_test_path(@site, response_test)).to match(/response_test/)

      response_time_test = FactoryGirl.create(:response_time_test, site: @site, content: 1000)
      expect(site_test_path(@site, response_time_test)).to match(/response_time_test/)

    end

  end

end
