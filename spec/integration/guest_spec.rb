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
    page.should have_content "Ask Anonymously or"
    page.should have_css('a img[src="/assets/twitter.png"]')
    page.should have_css('a img[src="/assets/facebook.png"]')
  end
end

def current_user
   user = User.create
end