

def sign_up(email: 'harry@harry.com',
            password: 'tester',
            password_confirmation: 'tester')
  visit '/users/sign_up'
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  fill_in :user_password_confirmation, with: password_confirmation
  click_button 'Sign up'
end
