class ApprovalsController < ApplicationController
  def create
    question = Question.find(params[:question_id])
    question.approved = true
    question.save
  end
  
  def destroy
    question = Question.find(params[:question_id])
    question.approved = false
  end 
end
