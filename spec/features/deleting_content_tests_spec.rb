require "rails_helper"

RSpec.feature "Users can delete content tests" do

  before do
    @user = FactoryGirl.create(:user)
    page.driver.post accounts_create_path, { user: { email: @user.email },
                                             app_host: { uid: @user.app_uid } } 
  end
    
  scenario "successfully" do
    site = FactoryGirl.create(:site, user: @user, name: "Google Status Page")
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
