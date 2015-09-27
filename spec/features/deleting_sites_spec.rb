require "rails_helper"

RSpec.feature "Users can delete sites" do
    
  scenario "successfully" do
    FactoryGirl.create(:site, name: "Google Status Page")

    visit "/"
    click_link "

end
