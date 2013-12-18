# require 'spec_helper' 
# 
# # feature "Signed in user" ,js: true do
#    let(:admin) { create(:admin)  }
#  
#   scenario "can ask a question" do
#     sign_in_admin(admin)
#     create_event
#     code = page.find('div#code').text  
#     click_link "Logout"
#     click_link "Join an event"
#     fill_in "Code",with: code
#     click_button "Join Event"
#     fill_in "body",with: "Hi how are you?"
#     click_button "Ask"
#     save_and_open_page
#     expect(page).to have_css '.questions',text: "Hi how are you?"
#     
#     expect(page).to have_css ".question .vote_button a",text: "Up"
#     expect(page).to have_css ".question .body",text: "Hi how are you?"
#     expect(page).to have_css ".question .votes",text: "0"
#   end
# end
# 
# def current_user
#   User.create()
# end
# def create_event
#   click_link "Create an event"
#   page.should have_button "Create Event"
#   fill_in "Name",with:"Oracle"
#   click_button "Create Event"
# end
# 
# def sign_in_admin(admin)
#   visit root_path
#   click_link "Admin Login"
#   fill_in "Email",with: admin.email
#   fill_in "Password",with:  admin.password
#   click_button "Sign in"
# end
# 
