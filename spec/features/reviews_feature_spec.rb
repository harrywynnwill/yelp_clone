require 'rails_helper'


feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}
  before(:each) do
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'testtest'
    fill_in 'Password confirmation', with: 'testtest'
    click_button 'Sign up'
  end

  scenario 'can review a restaurant' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'so so'
  end
  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end
  scenario 'displays an average rating for all the reviews' do
    leave_review('so so', '3')
    leave_review('FANTASTICHE', '5')
    expect(page).to have_content('Average rating: 4')
  end
end
