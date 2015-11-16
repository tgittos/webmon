require 'rails_helper'

RSpec.describe ContentTest, type: :model do
  
  it "checks the site after save" do
    site = FactoryGirl.create(:site)
    response_test = FactoryGirl.build(:response_test, site: site)
    expect(response_test).to receive(:check!).and_call_original
    response_test.save
  end

  it "successfully matches 200 status" do
    site = FactoryGirl.create(:site)
    response_test = FactoryGirl.build(:response_test, site: site, content: 200)
    count = TestResult.count
    response_test.save
    expect(TestResult.count).to eq count + 1 
    expect(response_test.test_results.latest.result).to eq true
  end

  it "doesn't match 200 status when looking for 500 status" do
    site = FactoryGirl.create(:site)
    response_test = FactoryGirl.build(:response_test, site: site, content: 500)
    count = TestResult.count
    response_test.save
    expect(TestResult.count).to eq count + 1 
    expect(response_test.test_results.latest.result).to eq false
  end

  it "does match 200 status when looking for 'not equal 500' status" do
    site = FactoryGirl.create(:site)
    response_test = FactoryGirl.build(:response_test, site: site, comparison: "not equal", content: 500)
    count = TestResult.count
    response_test.save
    expect(TestResult.count).to eq count + 1 
    expect(response_test.test_results.latest.result).to eq true
  end

  it "doesn't match 200 status when looking for 'not equal 200' status" do
    site = FactoryGirl.create(:site)
    response_test = FactoryGirl.build(:response_test, site: site, comparison: "not equal", content: 200)
    count = TestResult.count
    response_test.save
    expect(TestResult.count).to eq count + 1 
    expect(response_test.test_results.latest.result).to eq false
  end 

end
