class QuestionsController < ApplicationController
  respond_to :json
  def create 
    event = Event.find(params[:event_id])
    @question  = event.questions.new(question_params)
    # @question.approved = true # comment this out for production
    @question.save
    serializer = QuestionSerializer.new @question
    Pusher['test_channel'].trigger('my_event', {
         question: serializer,
         action: "add"
       })
  end
  
  def index
    event = Event.find(params[:event_id])
    @questions = event.questions
    respond_with @questions
  end
  
  def show
    question = Question.find(params[:id])
    respond_with question
  end

  private
 

  def question_params
    params.require(:question).permit(:body)
  end
end
