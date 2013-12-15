require 'spec_helper'

feature "View the homepage" do
  scenario "users sees relecant information" do
    visit root_path
    expect(page).to have_css "title",text: "Ask your question!"
    expect(page).to have_css "[data-role='nav-links']"
    expect(page).to have_link "Sign in with Twitter"
    expect(page).to have_link "Sign in with Facebook"
    expect(page).to have_content "Signed in as Guest"
  end
end

