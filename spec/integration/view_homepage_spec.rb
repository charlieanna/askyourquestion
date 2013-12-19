require 'spec_helper'

feature "View the homepage" do
  scenario "users sees links at the top" do
    visit root_path
    page.should have_title "Ask your question!" 
    page.should have_css "[data-role='nav-links']"
    page.should_not have_css('a img[src="/assets/twitter.png"]')
    page.should_not have_css('a img[src="/assets/facebook.png"]')
    page.should_not have_content "Signed in as Guest"
    page.should have_link "Login"
    page.should have_link "Signup"
    # page.should have_link "Create an event"
    page.should have_link "Join Event"
  end
end

