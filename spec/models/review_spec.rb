# spec/models/review_spec.rb
require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:score) }
    it { should validate_inclusion_of(:score).in_range(1..5) }
  end

  describe 'associations' do
    it { should belong_to(:airline) }
  end

  describe 'scopes' do
    let(:airline) { create(:airline) }
    let!(:old_review) { create(:review, airline: airline, created_at: 2.days.ago) }
    let!(:new_review) { create(:review, airline: airline, created_at: 1.day.ago) }

    describe '.recent' do
      it 'orders reviews by creation date descending' do
        expect(Review.recent).to eq([new_review, old_review])
      end
    end
  end
end