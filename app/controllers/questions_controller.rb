class QuestionsController < ApplicationController
  def create 
    @question  = Question.new(question_params)
    @question.save
    Pusher['test_channel'].trigger('my_event', {
         message: 'hello world'
       })
    redirect_to homes_path
  end
  
  def index
    @questions = Question.all
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end
end
