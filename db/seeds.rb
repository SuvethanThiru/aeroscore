# db/seeds.rb
# Create sample airlines
airlines_data = [
  {
    name: "Delta Air Lines",
    image_url: "https://images.unsplash.com/photo-1436491865332-7a61a109cc05?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
    description: "Major American airline known for reliable service and extensive domestic and international routes."
  },
  {
    name: "Emirates",
    image_url: "https://images.unsplash.com/photo-1569154941061-e231b4725ef1?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
    description: "Luxury Middle Eastern carrier offering premium services and connecting the world through Dubai."
  },
  {
    name: "Southwest Airlines",
    image_url: "https://images.unsplash.com/photo-1544148103-0773bf10d330?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
    description: "Low-cost American airline famous for friendly service and no baggage fees policy."
  },
  {
    name: "Singapore Airlines",
    image_url: "https://images.unsplash.com/photo-1583947215259-38e31be8751f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
    description: "Award-winning Asian carrier renowned for exceptional service quality and innovation."
  },
  {
    name: "Lufthansa",
    image_url: "https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
    description: "Germany's flag carrier offering extensive European and international connectivity."
  }
]

airlines_data.each do |airline_data|
  airline = Airline.find_or_create_by(name: airline_data[:name]) do |a|
    a.image_url = airline_data[:image_url]
    a.description = airline_data[:description]
  end
  
  # Create sample reviews for each airline
  if airline.reviews.empty?
    sample_reviews = [
      {
        title: "Excellent service and comfortable seats",
        description: "Had a wonderful experience flying with this airline. The staff was very professional and the seats were comfortable for the long flight.",
        score: 5
      },
      {
        title: "Good value for money",
        description: "Decent airline with reasonable prices. The food could be better but overall satisfied with the service.",
        score: 4
      },
      {
        title: "Average experience",
        description: "Nothing special but got me to my destination safely. The entertainment system was outdated.",
        score: 3
      },
      {
        title: "Impressed with the service",
        description: "The crew went above and beyond to make sure passengers were comfortable. Will definitely fly again.",
        score: 5
      },
      {
        title: "Delayed but handled well",
        description: "Flight was delayed but the airline kept us informed and provided compensation. Professional handling of the situation.",
        score: 4
      }
    ]
    
    # Create 3-7 random reviews per airline
    reviews_count = rand(3..7)
    reviews_count.times do
      review_data = sample_reviews.sample
      airline.reviews.create!(
        title: review_data[:title],
        description: review_data[:description],
        score: review_data[:score]
      )
    end
  end
end

puts "Created #{Airline.count} airlines with #{Review.count} total reviews"