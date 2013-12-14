require 'spec_helper' 

feature "Signed in user" do
  before do
    @question = Question.create(body:"Will IdleCampus ever be a company?")
    visit root_path
    fill_in "Body" , with: @question.body
    click_button "Ask"
  end
  
  scenario "can ask a question" do
    expect(page).to have_css '.questions',text: @question.body
    expect(page).to have_css ".question .vote_button a",text: "Up"
    expect(page).to have_css ".question .body",text: @question.body
    expect(page).to have_css ".question .votes",text: "0"
  end
end