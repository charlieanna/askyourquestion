class QuestionSerializer < ActiveModel::Serializer
  attributes :id,:body,:votes,:liked
  def body
    object.body
  end
  
  def liked
    if current_user
      current_user.liked? object 
    else
      false
    end
  end
  
  def votes
    object.votes.up.count
  end
end
