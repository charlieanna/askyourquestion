class QuestionsController < ApplicationController
  respond_to :json
  def create 
    event = Event.find(params[:event_id])
    @question  = event.questions.new(question_params)
    @question.save
    Pusher['test_channel'].trigger('my_event', {
         message: 'hello world'
       })
    @questions = event.questions
  end
  
  def index
    # event = Event.find(params[:event_id])
    @questions = Question.all
    respond_with @questions
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end
end
