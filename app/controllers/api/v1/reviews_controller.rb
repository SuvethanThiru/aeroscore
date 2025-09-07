# app/controllers/api/v1/reviews_controller.rb
class Api::V1::ReviewsController < ApplicationController
  before_action :set_airline
  before_action :set_review, only: [:show, :update, :destroy]
  
  def index
    reviews = @airline.reviews.recent.map do |review|
      {
        id: review.id,
        title: review.title,
        description: review.description,
        score: review.score,
        created_at: review.created_at.strftime('%B %d, %Y')
      }
    end
    
    render json: reviews
  end
  
  def show
    render json: {
      id: @review.id,
      title: @review.title,
      description: @review.description,
      score: @review.score,
      created_at: @review.created_at.strftime('%B %d, %Y')
    }
  end
  
  def create
    review = @airline.reviews.build(review_params)
    
    if review.save
      render json: review, status: :created
    else
      render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def update
    if @review.update(review_params)
      render json: @review
    else
      render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def destroy
    @review.destroy
    render json: { message: 'Review deleted successfully' }
  end
  
  private
  
  def set_airline
    @airline = Airline.find(params[:airline_id])
  rescue ActiveRecord::RecordNotFound
    render json { error: 'Airline not found' }, status: :not_found
  end
  
  def set_review
    @review = @airline.reviews.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Review not found' }, status: :not_found
  end
  
  def review_params
    params.require(:review).permit(:title, :description, :score)
  end
end