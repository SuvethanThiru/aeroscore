class Airline < ApplicationRecord
  has_many :reviews, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  validates :image_url, presence: true
  
  def avg_score
    return 0 if reviews.empty?
    reviews.average(:score).round(2)
  end
end