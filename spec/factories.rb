FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
  end

  factory :run do
    sequence(:date) { |n| Date.new(2012,8,29) + n }
    mins '56'
    distance '8'
    pace '420'
    user
  end
end