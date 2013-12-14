module UsersHelper
  def vote_button question
    if current_user.liked? question
      
      button_to "Down",question_vote_path(question),method: :delete
    else
      button_to "Up",question_vote_path(question)
    end
  end
end