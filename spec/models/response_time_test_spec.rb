require 'rails_helper'

RSpec.describe ContentTest, type: :model do

  before do
    @site = FactoryGirl.create(:site)
    # sites always take 100ms to respond
    Site.any_instance.stub(:fetch) do
      sleep(0.1)
      double("Object", body: "foobar")
    end
  end
  
  it "checks the site after save" do
    response_time_test = FactoryGirl.build(:response_time_test, site: @site)
    expect(response_time_test).to receive(:check!).and_call_original
    response_time_test.save
  end

  it "passes when site responds faster than 'less than' criteria" do
    response_time_test = FactoryGirl.build(:response_time_test, site: @site, content: 500)
    count = TestResult.count
    response_time_test.save
    expect(TestResult.count).to eq count + 1 
    expect(response_time_test.test_results.latest.result).to eq true
  end

  it "fails when site responds slower than 'less than' criteria" do
    response_time_test = FactoryGirl.build(:response_time_test, site: @site, content: 50)
    count = TestResult.count
    response_time_test.save
    expect(TestResult.count).to eq count + 1 
    expect(response_time_test.test_results.latest.result).to eq false
  end

  it "passes when site responds slower than 'greater than' criteria" do
    response_time_test = FactoryGirl.build(:response_time_test, site: @site, comparison: "greater than", content: 50)
    count = TestResult.count
    response_time_test.save
    expect(TestResult.count).to eq count + 1 
    expect(response_time_test.test_results.latest.result).to eq true
  end

  it "fails when site responds faster than 'greater_than' criteria" do
    response_time_test = FactoryGirl.build(:response_time_test, site: @site, comparison: "greater than", content: 500)
    count = TestResult.count
    response_time_test.save
    expect(TestResult.count).to eq count + 1 
    expect(response_time_test.test_results.latest.result).to eq false
  end 

end
