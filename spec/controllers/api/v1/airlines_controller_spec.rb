# spec/controllers/api/v1/airlines_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::AirlinesController, type: :controller do
  describe 'GET #index' do
    let!(:airline) { create(:airline) }
    let!(:review) { create(:review, airline: airline, score: 4) }

    before { get :index }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns airlines with calculated data' do
      json_response = JSON.parse(response.body)
      expect(json_response.first['name']).to eq(airline.name)
      expect(json_response.first['avg_score']).to eq(4.0)
      expect(json_response.first['reviews_count']).to eq(1)
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        airline: {
          name: 'New Airline',
          image_url: 'https://example.com/image.jpg',
          description: 'A new test airline'
        }
      }
    end

    context 'with valid parameters' do
      it 'creates a new airline' do
        expect {
          post :create, params: valid_params
        }.to change(Airline, :count).by(1)
      end

      it 'returns http created' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        { airline: { name: '' } }
      end

      it 'does not create a new airline' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Airline, :count)
      end

      it 'returns http unprocessable entity' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end