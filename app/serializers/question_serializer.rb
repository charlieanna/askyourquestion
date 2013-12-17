class QuestionSerializer < ActiveModel::Serializer
  attributes :id,:body,:votes,:liked
  def body
    object.body
  end
  
  def liked
    object.liked_by current_user
  end
  
  def votes
    object.votes.up.count
  end
end
