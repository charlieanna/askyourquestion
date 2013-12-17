class QuestionSerializer < ActiveModel::Serializer
  attributes :id,:body,:votes,:liked
  def body
    object.body
  end
  
  def liked
   current_user.liked? object 
  end
  
  def votes
    object.votes.up.count
  end
end
