require 'spec_helper'

feature "Guest" do
  before do
    @event = FactoryGirl.create(:event)
    visit root_path
  end
  scenario "can join a event"do
    click_link "Join an event"
    fill_in "Code",with: @event.code
    click_button "Join Event"
    page.should have_content "Event joined. You can ask your questions and vote for them now."
  end
end

def current_user
   user = User.create
end