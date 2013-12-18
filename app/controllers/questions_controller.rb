class QuestionsController < ApplicationController
  respond_to :json
  def create 
    event = Event.find(params[:event_id])
    @question  = event.questions.new(question_params)
    @question.save
    serializer = QuestionSerializer.new @question
    @my_callback = lambda { |message| puts(message) }

    ## Execute Publish
    @pubnub.publish(
        :channel  => :a,
        :message  => {question:serializer,action:"add"},
        :callback => @my_callback
    )
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
