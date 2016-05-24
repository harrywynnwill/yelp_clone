require 'rails_helper'
feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

  scenario 'can review a restaurant' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: 'so so'
    select '3', from: 'Rating'
    click button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'so so'
  end
end