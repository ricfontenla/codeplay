FactoryBot.define do
  factory :instructor do
    sequence(:email) { |n| "fulano#{n}@codeplay.com.br" }
    name { 'Fulano Fulano' }
    bio { 'Dev e instrutor na Code Play' }
  end
end