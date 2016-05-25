require 'spec_helper'

RSpec.describe Restaurant, type: :model do

  describe 'data validation' do
    it 'is not valid with a name of less than three chars' do
      restaurant = Restaurant.new(name: "kf")
      expect(restaurant).to have(1).error_on(:name)
      expect(restaurant).not_to be_valid
    end
    it 'is not a valid unique name' do
      Restaurant.create(name: "Moe's Tavern")
      restaurant = Restaurant.new(name: "Moe's Tavern")
      expect(restaurant).to have(1).error_on(:name)
    end
  end
end
