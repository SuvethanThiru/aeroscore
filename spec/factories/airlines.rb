# spec/factories/airlines.rb
FactoryBot.define do
  factory :airline do
    name { "Test Airlines" }
    image_url { "https://example.com/image.jpg" }
    description { "A test airline for specifications" }
  end
end