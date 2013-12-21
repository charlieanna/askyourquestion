require 'spec_helper'

feature "Guest" do
  before do
    
    @event = FactoryGirl.create(:event)
     
    visit root_path
  end
  scenario "can join a event" do
    fill_in "subscriber_code",with: @event.code
    click_button "Join Event"
    page.should have_content "Event joined. You can ask your questions and vote for them now."
    page.should have_content "ASK YOUR QUESTION"
    page.should have_content "as Guest"
    page.should have_css('a img[src="/assets/twitter.png"]')
    page.should have_css('a img[src="/assets/facebook.png"]')
    page.should have_css ".questions"
    page.should have_css ".new_question #body"
  end
  
  scenario "should not see the question after he asks" do
     
    question = build(:question)
    fill_in "subscriber_code",with: question.event.code
    click_button "Join Event"
    fill_in "body",with: question.body
    click_button "Ask"
    page.should_not have_content question.body
  end
  
  scenario "should see the question after it has been accepted" do
     
    question = build(:question)
    fill_in "subscriber_code",with: question.event.code
    click_button "Join Event"
    fill_in "body",with: question.body
    click_button "Ask"
    click_link "Logout"
    sign_in_admin(question.event.admin)
    page.should have_content "Hi how are you?"
    page.should have_button "approve"
    page.should have_button "reject"
    click_button "approve"
    click_link "Logout"
    fill_in "subscriber_code",with: question.event.code
    click_button "Join Event"
    page.should have_content question.body
  end
  
  scenario "can vote on a question" do
    question = create(:question,approved: true)
    fill_in "subscriber_code",with: question.event.code
    click_button "Join Event"
    page.should have_content question.body
    page.should have_button "up"
  end
  
  scenario "cannot vote on a question that is still pending with the admin" do
     
    question = create(:question)
    fill_in "subscriber_code",with: question.event.code
    click_button "Join Event"
    page.should_not have_content question.body
    page.should_not have_button "up"
  end
  
  scenario "cannot vote on a question that is has been rejected by admin" do
     
    question = create(:question)
    
    fill_in "subscriber_code",with: question.event.code
    click_button "Join Event"
    page.should_not have_content question.body
    page.should_not have_button "up"
  end
  
  scenario "should be able to logout" do
    fill_in "subscriber_code",with: @event.code
    click_button "Join Event"
    page.should have_link "Logout"
    click_link "Logout"
    page.should have_button "Join Event"
  end
end

def current_user
   user = User.create
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
