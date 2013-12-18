class HomesController < ApplicationController
  def show
    
    @my_callback = lambda { |message| puts(message) }

    ## Execute Publish
    @pubnub.publish(
        :channel  => :a,
        :message  => {text:"Hi"},
        :callback => @my_callback
    )
    @question = Question.new
    @questions = Question.all
    unless session[:user_id]
      @user = User.new_guest
      if @user.save
        session[:user_id] = @user.id
      end
    end
  end
end
