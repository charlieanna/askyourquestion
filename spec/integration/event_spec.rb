require 'spec_helper'

feature "Guest" do
   let(:admin) { create(:admin)  }
  scenario "and see the question on the screen below" ,js: true do
              sign_in_admin(admin)
              create_event
              code = page.find('div#code').text  
              click_link "Logout"
              click_link "Join an event"
              fill_in "Code",with: code
              click_button "Join Event"
              fill_in "body",with: "Hi how are you?"
              click_button "Ask"
              page.should have_content "Hi how are you? 0"
 end
end

def current_user
  User.create
end


def sign_up_admin 
  visit root_path
  click_link "Sign up to create an event"
  fill_in "Email",with: "admin@admin.com"
  fill_in "Password",with: "a"*8
  fill_in "Password confirmation",with: "a"*8
  click_button "Sign up"
end

def open_page
  save_and_open_page
end

def sign_in_admin(admin)
  visit root_path
  click_link "Login"
  fill_in "Email",with: admin.email
  fill_in "Password",with:  admin.password
  click_button "Sign in"
end

def create_event
  click_link "Create an event"
  page.should have_button "Create Event"
  fill_in "Name",with:"Oracle"
  click_button "Create Event"
end