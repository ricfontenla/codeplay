FactoryBot.define do
  factory :lesson do
    name { 'Lógica de Programação' }
    content { 'Conceitos de lógica de programação' }
    duration { rand (1..10) } 
    course
  end
end