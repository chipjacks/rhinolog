FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"
  end

  factory :run do
    sequence(:date) { |n| Date.new(2012,8,29) + n }
    time_in_secs '4800'
    distance '8'
    pace_in_secs '600'
    user
  end
end