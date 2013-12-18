class VotesController < ApplicationController
  respond_to :json
  def create
    event = question.event
    current_user.like question
    serializer = QuestionSerializer.new question
    puts serializer
    Pusher['test_channel'].trigger('my_event', {
         question: serializer,
         action: "like"
       })
    redirect_to question_path(question)
  end
  
  def destroy
    event = question.event
    current_user.dislike question
    serializer = QuestionSerializer.new question
    Pusher['test_channel'].trigger('my_event', {
         question: serializer,
         action: "dislike"
       })
    redirect_to question_path(question)
  end
  
  private
  
  def question
     @_question ||= Question.find(params[:question_id])
  end
end