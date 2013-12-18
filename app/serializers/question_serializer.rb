class QuestionSerializer < ActiveModel::Serializer
  attributes :id,:body,:votes,:liked
  def body
    object.body
  end
  
  def liked
    true
    # if current_user.liked? object 
#       true
#     else
#       false
#     end
  end
  
  def votes
    object.votes.up.count
  end
end
