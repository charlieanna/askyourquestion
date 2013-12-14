class UsersController < ApplicationController
  def create
    @user = User.new_guest
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url
    else
      render "new"
    end
  end
end