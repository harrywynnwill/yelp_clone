require 'rails_helper'

feature 'Users can sign in and out' do
  context ' user not signed in on the homepage' do
    it "should see a 'sign in' link and 'sign up' link" do
      visit '/'
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end
    it "should not see a 'sign out' link" do
      visit '/'
      expect(page).not_to have_link('Sign out')
    end
  end
  context "user signed in on the homepage" do
    before do
      visit '/'
      click_link('Sign up')
      fill_in('Email', with: 'harry@win.com')
      fill_in('Password', with: 'tester')
      fill_in('Password confirmation', with: 'tester')
      click_button('Sign up')
    end
    it "should see 'sign out' link" do
      visit '/'
      expect(page).to have_link('Sign out')
    end
    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end
end
