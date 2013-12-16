require 'spec_helper'

feature "Admin can signup" do
  let(:admin) { create(:admin)  }
  scenario 'with valid email address and password' do
    sign_up_admin
    page.should have_content("Welcome! You have signed up successfully. Logged in as admin@admin.com.")
    page.should have_link "Logout"
    page.should have_link "Edit profile"
    page.should have_link "Create an event"
  end
  
  context "create an event." do
    scenario "with a name" do
      sign_in_admin(admin)
      create_event
      page.should have_css ".questions"
    end
    
    context "guest can join the event" do
      scenario "with a valid event code" do
        sign_in_admin(admin)
        create_event
        code = page.find('div#code').text  
        click_link "Logout"
        click_link "Join an event"
        fill_in "Code",with: code
        click_button "Join Event"
        page.should have_content "Event joined. You can ask your questions and vote for them now."
      end
      
      context "and then ask a question",js: true do
        scenario "which sends the question to the admin for approval" do
          sign_in_admin(admin)
          create_event
          code = page.find('div#code').text  
          click_link "Logout"
          click_link "Join an event"
          fill_in "Code",with: code
          click_button "Join Event"
          fill_in "Body",with: "Hi how are you?"
          click_button "Ask"
          sign_in_admin(admin)
          page.should have_content "Hi how are you?"
          page.should have_link "Approve"
          page.should have_link "Reject"
          click_link "Approve"
          click_link "Logout"
          click_link "Join an event"
          fill_in "Code",with: code
          click_button "Join Event"
          # page.should have_css "#question_1 .votes",text: "0 votes"
          click_link "Up"
           # open_page
          page.should have_css "#question_1 .votes",text: "1 vote"
          
        end
        scenario "which sends the question to the admin for approval" do
          sign_in_admin(admin)
          create_event
          code = page.find('div#code').text  
          click_link "Logout"
          click_link "Join an event"
          fill_in "Code",with: code
          click_button "Join Event"
          fill_in "Body",with: "Hi how are you?"
          click_button "Ask"
          sign_in_admin(admin)
          page.should have_content "Hi how are you?"
          page.should have_link "Approve"
          page.should have_link "Reject"
          click_link "Reject"
          click_link "Logout"
          click_link "Join an event"
          fill_in "Code",with: code
          click_button "Join Event"
          # page.should have_css "#question_1 .votes",text: "0 votes"
          click_link "Up"
           # open_page
          page.should have_css "#question_1 .votes",text: "0 votes"
          open_page
        end
      end
    end
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

def open_page
  save_and_open_page
end

def sign_in_admin(admin)
  visit root_path
  click_link "Admin Login"
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