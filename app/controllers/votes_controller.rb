class VotesController < ApplicationController
  def create
    question = Question.find(params[:question_id])
    event = question.event
    current_user.like question
    @questions = event.questions
    alert_client(event)
  end
  
  def destroy
    question = Question.find(params[:question_id])
    current_user.dislike question
    event = question.event
    @questions = event.questions
    alert_client(event)
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