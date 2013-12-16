FactoryGirl.define do
  factory :admin do
    email "admin@admin.com"
    password "aaaaaaaa"
    password_confirmation { "aaaaaaaa" }
  end
end