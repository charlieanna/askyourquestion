class ApprovalsController < ApplicationController
  def create
    question = Question.find(params[:question_id])
    question.approved = true
    question.save
    puts question.approved
    serializer = QuestionSerializer.new question
    @my_callback = lambda { |m| "nothing" }
    @pubnub.publish(
        :channel  => question.event.code,
        :message  => {question:serializer,action:"approved"},
        :callback => @my_callback
    )
     redirect_to question_path(question)
  end
  
  def destroy
    question = Question.find(params[:question_id])
    question.approved = false
    question.save
    serializer = QuestionSerializer.new question
      @my_callback = lambda { |m| "nothing" }

    ## Execute Publish
    @pubnub.publish(
        :channel  => question.event.code,
        :message  => {question:serializer,action:"disapproved"},
        :callback => @my_callback
    )
     redirect_to question_path(question)
  end 
end
