# spec/models/airline_spec.rb
require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:image_url) }
  end

  describe 'associations' do
    it { should have_many(:reviews).dependent(:destroy) }
  end

  describe '#avg_score' do
    let(:airline) { create(:airline) }

    context 'when airline has no reviews' do
      it 'returns 0' do
        expect(airline.avg_score).to eq(0)
      end
    end

    context 'when airline has reviews' do
      before do
        create(:review, airline: airline, score: 4)
        create(:review, airline: airline, score: 5)
      end

      it 'returns the average score' do
        expect(airline.avg_score).to eq(4.5)
      end
    end
  end
end