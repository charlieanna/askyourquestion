require 'spec_helper'

feature "User visits the homepage" do
  scenario "and sees the appropriate content" do
    visit root_path
    page.should have_title "Ask your question!" 
    page.should have_css "[data-role='nav-links']"
    page.should have_link "Login"
    page.should have_link "Signup"
    page.should have_button "Join Event"
  end
end

