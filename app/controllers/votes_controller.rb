class VotesController < ApplicationController
  respond_to :json
  before_filter :set_question_user
  
 
  def create
    event = question.event
    current_user.like question
    question.user = current_user
    serializer = QuestionSerializer.new question
    puts serializer
    @my_callback = lambda { |message| puts(message) }

    ## Execute Publish
    puts question.liked_by current_user
    @pubnub.publish(
        :channel  => :a,
        :message  => {question:serializer,action:"like"},
        :callback => @my_callback
    )
    redirect_to question_path(question)
  end
  
  def destroy
    event = question.event
    current_user.dislike question
    question.user = current_user
    serializer = QuestionSerializer.new question
    @my_callback = lambda { |message| puts(message) }

    ## Execute Publish
    @pubnub.publish(
        :channel  => :a,
        :message  => {question:serializer,action:"dislike"},
        :callback => @my_callback
    )
    redirect_to question_path(question)
  end
  
  private
  
  def set_question_user
    question.user = current_user
  end
  
  def question
     @_question ||= Question.find(params[:question_id])
  end
end