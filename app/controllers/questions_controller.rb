class QuestionsController < ApplicationController
  def create 
    @question  = Question.new(question_params)
    @question.save
    redirect_to homes_path
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end
end
