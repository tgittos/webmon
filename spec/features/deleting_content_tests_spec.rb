require "rails_helper"

RSpec.feature "Users can delete content tests" do
    
  scenario "successfully" do
    site = FactoryGirl.create(:site, name: "Google Status Page")
    content_test = FactoryGirl.create(:content_test, site: site, content: "foobar")

    visit "/"
    click_link "Google Status Page"
    click_link content_test.to_s
    click_link "Delete Content Test"

    expect(page).to have_content "Content test  has been deleted."
    expect(page.current_url).to eq site_url(site)
    expect(page).to have_no_content content_test.to_s
  end

end
