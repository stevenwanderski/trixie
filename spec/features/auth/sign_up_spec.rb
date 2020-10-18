require 'rails_helper'

describe 'Sign up' do
  it 'redirects to URL setup form' do
    visit new_user_registration_path
    fill_in 'user_email', with: 'frank@zappa.com'
    fill_in 'user_password', with: 'testtest'
    fill_in 'user_password_confirmation', with: 'testtest'
    click_button 'Sign up'

    expect(page).to have_current_path(dashboard_slug_path)
  end
end
