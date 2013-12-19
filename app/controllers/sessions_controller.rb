class SessionsController < ApplicationController
  # user shouldn't have to be logged in before logging in!
  skip_before_filter :set_current_user
  def create
    
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"],auth["uid"]) || User.create_with_omniauth(auth)
    if current_user.event.present?
       current_user.event.users << user
    end  
    current_user.delete
    session[:user_id] = user.id
    if current_user.event.present?
       redirect_to current_user.event
     else
       redirect_to root_path
    end
    
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
    redirect_to  '/'
  end
end