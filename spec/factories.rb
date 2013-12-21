FactoryGirl.define do
  factory :admin do
    sequence :email do |n|
        "admin#{n}@admin.com"
      end
    password "aaaaaaaa"
    password_confirmation { "aaaaaaaa" }
  end
  
  factory :event do
    name "Oracle" 
    sequence(:code,10) do |n|
        "ABCD#{n}"
      end
    admin
  end
  
  factory :question do
    body "Hi how are you?"
    approved false
    event
  end
end