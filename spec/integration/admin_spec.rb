require 'spec_helper'
feature "Admin" do
  let(:admin) { create(:admin)  }
context "can signup" do
  
  scenario 'with valid email address and password' do
    sign_up_admin
    page.should have_content("Welcome! You have signed up successfully.")
    page.should have_link "Logout"
    page.should have_button "Create Event"
  end
end

context "after signup" do
  
  scenario 'can logout' do
    sign_up_admin
    click_link "Logout"
    page.should have_title "Ask your question!" 
    page.should have_css "[data-role='nav-links']"
    page.should have_link "Login"
  end
end
  
  context "create an event" do
    scenario "with a name" do
      sign_in_admin(admin)
      create_event
      code = page.find('div span#code').text  
      page.should have_content "Oracle created with code #{code}"
      page.should have_css ".questions"
    end
    context "and guest can join the event" do
      scenario "with a valid event code" do
        sign_in_admin(admin)
        create_event
        code = page.find('div span#code').text  
        click_link "Logout"
        fill_in "subscriber_code",with: code
        click_button "Join Event"
        page.should have_content "Event joined. You can ask your questions and vote for them now."
      end
    end
  end
  
  context "can logout" do
    scenario "and be shown to signin again" do
      sign_in_admin(admin)
      click_link "Logout"
      page.should have_title "Ask your question!" 
      page.should have_css "[data-role='nav-links']"
      page.should have_link "Login"
      page.should have_button "Join Event"
    end
  end
end

def sign_up_admin 
  visit root_path
   first(:link, "Signup").click
  fill_in "admin_email",with: "admin@admin.com"
  fill_in "admin_password",with: "a"*8
  fill_in "admin_password_confirmation",with: "a"*8
  click_button "Sign up"
end

def open_page
  save_and_open_page
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