class QuestionSerializer < ActiveModel::Serializer
  attributes :id,:body,:votes,:liked
  def body
    object.body
  end
  
  def liked
    if object.liked_by_current_user
      return true
    else
      return false
    end
  end
  
  def votes
    object.votes.up.count
  end
end
