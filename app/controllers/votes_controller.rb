class VotesController < ApplicationController
  respond_to :json
  def create
    event = question.event
    current_user.like question
    alert_client(event)
    redirect_to question_path(question)
  end
  
  def destroy
    event = question.event
    current_user.dislike question
    alert_client(event)
    redirect_to question_path(question)
  end
  
  private
  
  def question
     @_question ||= Question.find(params[:question_id])
  end
  
  def alert_client(event)
    Pusher['test_channel'].trigger('my_event', {
         event_id: event.id
       })
  end
end