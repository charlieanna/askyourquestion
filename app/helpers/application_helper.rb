module ApplicationHelper
  def current_user
    if session[:user_id].nil?
      current_user = User.new_guest
      current_user.save
      session[:user_id] = @user.id
    else
      current_user = User.find(session[:user_id])
    end
    return current_user
  end
end
