require 'rails_helper'

RSpec.describe ContentTest, type: :model do
  
  it "checks the site after save" do
    site = FactoryGirl.create(:site)
    content_test = FactoryGirl.build(:content_test, site: site)
    expect(content_test).to receive(:check!).and_call_original
    content_test.save
  end

  it "successfully finds content when present" do
    site = FactoryGirl.create(:site)
    content_test = FactoryGirl.build(:content_test, site: site, content: "queried")
    count = TestResult.count
    content_test.save
    expect(TestResult.count).to eq count + 1 
    expect(content_test.test_results.latest.result).to eq true
  end

  it "doesn't find content when present" do
    site = FactoryGirl.create(:site)
    content_test = FactoryGirl.build(:content_test, site: site, content: "foobar")
    count = TestResult.count
    content_test.save
    expect(TestResult.count).to eq count + 1 
    expect(content_test.test_results.latest.result).to eq false
  end

  it "successfully doesn't find content when comparison is 'doesnt match'" do
    site = FactoryGirl.create(:site)
    content_test = FactoryGirl.build(:content_test, site: site, comparison: "doesn't match", content: "foobar")
    count = TestResult.count
    content_test.save
    expect(TestResult.count).to eq count + 1 
    expect(content_test.test_results.latest.result).to eq true
  end

  it "does find content when comparison is 'doesnt match'" do
    site = FactoryGirl.create(:site)
    content_test = FactoryGirl.build(:content_test, site: site, comparison: "doesn't match", content: "queried")
    count = TestResult.count
    content_test.save
    expect(TestResult.count).to eq count + 1 
    expect(content_test.test_results.latest.result).to eq false
  end 

end
