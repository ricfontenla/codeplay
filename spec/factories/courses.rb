FactoryBot.define do
  factory :course do
    name { ['Ruby', 'Ruby on Rails', 'JavaScript'].sample }
    description { 'Um curso de Ruby' }
    sequence(:code) { |n| "RUBYBASIC#{n}" }
    price { rand(10..100) }
    enrollment_deadline { Date.current }
    instructor

    trait :with_lessons do
      after(:create) do |course, evaluator|
        create_list(:lesson, 2, course: course)
    end
  end
end