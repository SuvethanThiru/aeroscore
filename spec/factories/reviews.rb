# spec/factories/reviews.rb
FactoryBot.define do
  factory :review do
    title { "Great flight experience" }
    description { "Had an amazing time flying with this airline." }
    score { 5 }
    association :airline
  end
end