require 'rails_helper'



feature 'restaurants' do
  before(:each) do
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'testtest'
    fill_in 'Password confirmation', with: 'testtest'
    click_button 'Sign up'
  end
  context 'no restaurants have been added' do
    scenario 'displays a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end
  context 'restaurant has been added' do
    before do
      Restaurant.create(name: 'Nobu');
    end
    scenario 'restaurant is added to the list'do
      visit '/restaurants'
      expect(page).to_not have_content 'No restaurants yet'
      expect(page).to have_content 'Nobu'
    end
  end
  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link  'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end
    scenario 'a picture can be added to the restaurant' do
      visit '/restaurants'
      click_link  'Add a restaurant'
      fill_in 'Name', with: 'Maccy Ds'
      page.attach_file('restaurant_image', './public/kfc.jpg')
      click_button 'Create Restaurant'
    #  expect(page).to have_xpath("//img[@src='./public/kfc.jpg']")
      expect(page).to have_css("img[src*='kfc.jpg']")
    end
    context ' an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        visit '/restaurants'
        click_link  'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end
  context 'viewing restaurants'do
  let!(:kfc) {Restaurant.create(name: 'KFC')}
    scenario 'let a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end
  context 'editing a restaurant' do
    before {Restaurant.create(name: 'KFC', description: 'disgusting chicken')}
    scenario 'user can edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to_not have_content 'Kentucky fried goodness'
      expect(current_path).to eq '/restaurants'
    end
  end
  context 'deleting restaurants' do
    before {Restaurant.create(name: 'KFC', description: 'incredulous chickhan')}
    scenario 'removes the restuarant when user clicks delete' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).to_not have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end
end
