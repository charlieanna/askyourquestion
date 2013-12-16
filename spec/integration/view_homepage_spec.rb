require 'spec_helper'

feature "View the homepage" do
  scenario "users sees links at the top" do
    visit root_path
    page.should have_title "Ask your question!" 
    page.should have_css "[data-role='nav-links']"
    page.should have_css('a img[src="/assets/twitter.png"]')
    page.should have_css('a img[src="/assets/facebook.png"]')
    page.should have_content "Signed in as Guest"
    page.should have_link "Admin Login"
    page.should have_link "Sign up to create an event"
    page.should have_link "Create an event"
    page.should have_link "Join an event"
  end
end

