class VotesController < ApplicationController
  def create
    question = Question.find(params[:question_id])
    event = question.event
    current_user.like question
    @questions = event.questions
    alert_client
  end
  
  def destroy
    question = Question.find(params[:question_id])
    current_user.dislike question
    event = question.event
    @questions = event.questions
    alert_client
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