require 'spec_helper'

feature "Admin can signup" do
  
  scenario 'with valid email address and password' do
    sign_up_admin
    page.should have_content("Welcome! You have signed up successfully. Logged in as admin@admin.com.")
    page.should have_link "Logout"
    page.should have_link "Edit profile"
    page.should have_link "Create an event"
  end
  
  scenario "and create an event." do
    sign_up_admin
    click_link "Create an event"
    page.should have_button "Create Event"
    fill_in "Name",with:"Oracle"
    click_button "Create Event"
    page.should have_css ".questions"
  end
end

def sign_up_admin 
  visit root_path
  click_link "Sign up to create an event"
  fill_in "Email",with: "admin@admin.com"
  fill_in "Password",with: "a"*8
  fill_in "Password confirmation",with: "a"*8
  click_button "Sign up"
end