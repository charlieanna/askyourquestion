class ApprovalsController < ApplicationController
  def create
    question = Question.find(params[:question_id])
    question.approved = true
  end
  
  def destroy
    question = Question.find(params[:question_id])
    question.approved = false
  end 
end
