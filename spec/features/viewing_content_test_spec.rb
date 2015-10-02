require 'rails_helper'

RSpec.describe "user can view content test" do

  before do
    @site = FactoryGirl.create(:site, name: "Google Status Page")
    @content_test = FactoryGirl.create(:content_test, site: @site, content: "foobar")
    
    # 9 times, cause creating the initial content test creates a test_status
    9.times do
      FactoryGirl.create(:test_status, content_test: @content_test, result: true)
    end

    visit site_content_test_path(@site, @content_test)
  end

  scenario "with the site name" do
    expect(page).to have_content @site.name 
  end

  scenario "with the matching criteria" do
    expect(page).to have_content "#{@content_test.comparison} \"#{@content_test.content}\""
  end

  scenario "with history of results" do
    expect(find('#results ul')).to have_selector('li', count: 10)
    expect(find('#results')).to have_css('li.ok')
  end

end
