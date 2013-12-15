class SubscribersController < ApplicationController
  def create
    event = Event.find_by(code:params[:subscriber][:code])
    unless event.nil?
      event.users << current_user
      redirect_to root_path,notice:"Event joined. You can ask your questions and vote for them now."
    else
      redirect_to root_path,alert:"Event not found."
    end
  end
  
  def destroy
  end
  
  def new
   
  end
end
