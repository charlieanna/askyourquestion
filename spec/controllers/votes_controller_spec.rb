require 'spec_helper'

describe VotesController do
  before do
    
    @event = Event.create(name:"Amazon")
    @question = @event.questions.create(body:"Will IdleCampus ever be a company?",approved: true)
    @user = User.new_guest
    if @user.save
      session[:user_id] = @user.id
    end
  end
  
  describe 'POST #create' do
    context "increases the number of likes of the question" do
      it "returns to the root_path" do
      xhr  :post, :create,question_id: @question
        expect(@question.likes.count).to be(1)
      end
    end
  end
  
  describe 'DELETE #destroy' do
    context "decreases the number of likes of the question" do
      it "returns to the root_path" do
        @user.like @question
      xhr :delete, :destroy,question_id: @question
        expect(@question.likes.count).to be(0)
      end
    end
  end
end
def current_user
  User.create()
end