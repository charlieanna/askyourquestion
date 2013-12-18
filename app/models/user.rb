class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
 #         :recoverable, :rememberable, :trackable, :validatable
  acts_as_voter
  belongs_to :event
  has_many :questions
  def self.create_with_omniauth(auth)
    User.create!(
      :provider => auth["provider"],
      :uid => auth["uid"],
      :name => auth["info"]["name"])
  end
  
  def self.new_guest
     new { |u| u.guest = true  }
  end
  
  def username
    guest ? "Guest" : name
  end
  
  def like(question)
    if question.approved?
      likes(question)
      question.liked_by_current_user = true
      true
    else
      false
    end
  end
  def dislike(question)
    if question.approved?
      dislikes(question)
      question.liked_by_current_user = false
      true
    else
      false
    end
  end
  
  private :likes,:dislikes
end
