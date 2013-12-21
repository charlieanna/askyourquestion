require 'spec_helper'

describe ApprovalsController do
  before do
    @event = Event.create(name:"Amazon")
    @question = @event.questions.create(body:"Will IdleCampus ever be a company?",approved: false)
    @user = User.new_guest
    if @user.save
      session[:user_id] = @user.id
    end
  end
  
  describe 'POST #create' do
    context "approves the question" do
      it "so that others can now vote" do
        expect{xhr  :post, :create,question_id: @question}.to change{Question.first.approved}.from(false).to(true)
      end
    end
  end
  
  describe 'DELETE #destroy' do
    context "rejects the question" do
      it "to remove the question from getting voted" do
        @question.approved = true
        @question.save
       expect{xhr  :delete, :destroy,question_id: @question}.to change{Question.first.approved}.from(true).to(false)
      end
    end
  end
end
def current_user
  User.create()
end