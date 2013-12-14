def current_user
  puts "hi"
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end
