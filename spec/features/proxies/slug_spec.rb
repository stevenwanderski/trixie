require 'rails_helper'

describe 'Proxies: Slug' do
  before do
    @user = create(:user)
    login_as(@user)
  end

  it 'saves the slug and redirects to wizard step one' do
    visit dashboard_slug_path
    fill_in 'user_slug', with: 'mothers-of-invention'
    click_button 'Save'

    expect(page).to have_current_path(dashboard_proxy_wizard_step_one_path)
    expect(@user.reload.slug).to eq('mothers-of-invention')
  end
end
