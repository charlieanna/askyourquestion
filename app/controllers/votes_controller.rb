class VotesController < ApplicationController
  
  
  def create
    current_user.like question
    alert_client
    redirect_to root_path, notice: "Now following user."
  end
  
  def destroy
    current_user.dislike question
    alert_client
    redirect_to root_path, notice: "No longer following user."
  end
  
  private
  
  def question
     @_question ||= Question.find(params[:question_id])
  end
  
  def alert_client
    Pusher['test_channel'].trigger('my_event', {
         message: 'hello world'
       })
  end
end