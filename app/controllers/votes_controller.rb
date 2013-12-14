class VotesController < ApplicationController
  
  
  def create
    current_user.likes question
    redirect_to root_path, notice: "Now following user."
  end
  
  def destroy
    current_user.dislikes question
    redirect_to root_path, notice: "No longer following user."
  end
  
  private
  
  def question
     @_question ||= Question.find(params[:question_id])
  end
end