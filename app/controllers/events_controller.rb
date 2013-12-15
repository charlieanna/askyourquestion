class EventsController < ApplicationController
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(params.require(:event).permit(:name))
    @event.save
    redirect_to root_path,notice: "#{@event.name} created with code #{@event.code}"  
  end
  
  def show
    @event = Event.find(params[:id])
    if @event.users.include? current_user
      @questions = @event.questions
    else
      redirect_to root_path,alert:"You are not subscribed to this group."
    end
  end
end
