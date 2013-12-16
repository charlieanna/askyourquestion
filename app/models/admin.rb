class Admin < ActiveRecord::Base
  has_one :event
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  def event_code
    event.code
  end
  
  def event_name
    event.name
  end
end
