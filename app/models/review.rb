class Review < ApplicationRecord
  belongs_to :airline
  
  validates :title, presence: true
  validates :description, presence: true
  validates :score, presence: true, inclusion: { in: 1..5 }
  
  scope :recent, -> { order(created_at: :desc) }
end