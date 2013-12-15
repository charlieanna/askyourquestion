require 'spec_helper'

feature "New event" do
  scenario "A user should not be able to create a group" do
    visit '/'
    click_link "Create an event"
  end
end