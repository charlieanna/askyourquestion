class ApprovalsController < ApplicationController
  def create
    question = Question.find(params[:question_id])
    question.approved = true
    question.save
    serializer = QuestionSerializer.new question
    @my_callback = lambda { }

    ## Execute Publish
    @pubnub.publish(
        :channel  => question.event.code,
        :message  => {question:serializer,action:"approved"},
        :callback => @my_callback
    )
  end
  
  def destroy
    question = Question.find(params[:question_id])
    question.approved = false
    serializer = QuestionSerializer.new question
    @my_callback = lambda { }

    ## Execute Publish
    @pubnub.publish(
        :channel  => question.event.code,
        :message  => {question:serializer,action:"disapproved"},
        :callback => @my_callback
    )
  end 
end
