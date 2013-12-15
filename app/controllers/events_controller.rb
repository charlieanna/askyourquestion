class EventsController < ApplicationController
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(params.require(:event).permit(:name))
    @event.save
    redirect_to root_path,notice: "#{@event.name} created with code #{@event.code}"  
  end
  
  
  
end
