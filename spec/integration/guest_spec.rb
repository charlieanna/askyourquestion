require 'spec_helper'

feature "Guest" do
  before do
    @event = FactoryGirl.create(:event)
    visit root_path
  end
  scenario "can join a event"do
    click_link "Join Event"
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
    click_link "Join Event"
    fill_in "subscriber_code",with: @event.code
    click_button "Join Event"
    fill_in "body",with:"I love Ruby On Rails"
    click_button "Ask"
    page.should_not have_content "I love Ruby On Rails"
  end
  
  scenario "should be able to logout" do
    click_link "Join Event"
    fill_in "subscriber_code",with: @event.code
    click_button "Join Event"
    click_link "Logout"
  end
end

def current_user
   user = User.create
end