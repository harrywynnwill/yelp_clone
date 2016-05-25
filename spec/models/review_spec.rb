require 'rails_helper'

describe Review, type: :model do
  describe 'data validation' do
    it'does not allow a review over 5 points' do
      review = Review.new(rating: 6)
      expect(review).to have(1).error_on(:rating)
    end
  end
end
