require 'spec_helper'

feature "Sign in" do
  # before do
#       request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
#   end
  scenario "as a guest" do
    visit root_path
    expect(page).to have_content 'Signed in as Guest'
  end
  
  
  
  # scenario "as a facebook user" do
#     visit root_path
#     it "sets a session variable to the OmniAuth auth hash" do
#         request.env["omniauth.auth"][:uid].should == '123545'
#     end
#   end
#   
#   scenario "as a twitter user" do
#     visit root_path
#   end
end
