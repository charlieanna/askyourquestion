require 'spec_helper' 

feature "Signed in user" ,js: true do
  before do
    @event = Event.create(name:"Oracle")
    @question = @event.questions.build(body:"Will IdleCampus ever be a company?",approved: true)
    visit root_path
    click_link "Join an event"
    fill_in "subscriber_code",with: @event.code
    click_button "Join Event"
   
  end
  
  scenario "can ask a question" do
    fill_in "Body",with: @question.body
    click_button "Ask"
    expect(page).to have_css '.questions',text: @question.body
    expect(page).to have_css ".question .vote_button a",text: "Up"
    expect(page).to have_css ".question .body",text: @question.body
    expect(page).to have_css ".question .votes",text: "0"
  end
end