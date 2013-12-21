require 'spec_helper'

feature "Guest" do
   let(:admin) { create(:admin)  }
  scenario "and see the question on the screen below" ,js: true do
    sign_in_admin(admin)
    create_event
    code = page.find('div span#code').text 
    click_link "Logout"
    fill_in "subscriber_code",with: code
    click_button "Join Event"
    fill_in "body",with: "Hi how are you?"
    click_button "Ask"
    click_link "Logout"
    sign_in_admin(admin)
    page.should have_content "Hi how are you?"
    page.should have_button "approve"
    page.should have_button "reject"
    click_button "approve"
    click_link "Logout"
    fill_in "subscriber_code",with: code
    click_button "Join Event"
    page.should have_content "Hi how are you?"
    click_button "up"
    click_link "Logout"
    fill_in "subscriber_code",with: code
    click_button "Join Event"
    votes = page.find('#votes').text 
    expect(votes).to eq("1")
 end
end

def current_user
  User.create
end

def open_page
  save_and_open_page
end

def sign_up_admin 
  visit root_path
  first(:link, "Signup").click
  fill_in "admin_email",with: "admin@admin.com"
  fill_in "admin_password",with: "a"*8
  fill_in "admin_password_confirmation",with: "a"*8
  click_button "Sign up"
end



def sign_in_admin(admin)
  visit root_path
  click_link "Login"
  fill_in "admin_email",with: admin.email
  fill_in "admin_password",with:  admin.password
  click_button "Sign in"
end

def create_event
  fill_in "event_name",with:"Oracle"
  click_button "Create Event"
end