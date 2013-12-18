class HomesController < ApplicationController
  def show
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
