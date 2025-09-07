# app/controllers/api/v1/airlines_controller.rb
class Api::V1::AirlinesController < ApplicationController
  before_action :set_airline, only: [:show, :update, :destroy]
  
  def index
    airlines = Airline.all.map do |airline|
      {
        id: airline.id,
        name: airline.name,
        image_url: airline.image_url,
        description: airline.description,
        avg_score: airline.avg_score,
        reviews_count: airline.reviews.count
      }
    end
    
    render json: airlines
  end
  
  def show
    render json: {
      id: @airline.id,
      name: @airline.name,
      image_url: @airline.image_url,
      description: @airline.description,
      avg_score: @airline.avg_score,
      reviews: @airline.reviews.recent.limit(10).map do |review|
        {
          id: review.id,
          title: review.title,
          description: review.description,
          score: review.score,
          created_at: review.created_at.strftime('%B %d, %Y')
        }
      end
    }
  end
  
  def create
    airline = Airline.new(airline_params)
    
    if airline.save
      render json: airline, status: :created
    else
      render json: { errors: airline.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def update
    if @airline.update(airline_params)
      render json: @airline
    else
      render json: { errors: @airline.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def destroy
    @airline.destroy
    render json: { message: 'Airline deleted successfully' }
  end
  
  private
  
  def set_airline
    @airline = Airline.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Airline not found' }, status: :not_found
  end
  
  def airline_params
    params.require(:airline).permit(:name, :image_url, :description)
  end
end