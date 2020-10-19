require 'rails_helper'

describe 'Proxies: Wizard: Step Four' do
  let(:user) { create(:user) }

  before do
    login_as(user)
  end

  it 'saves and redirects to step two' do
    visit dashboard_proxy_wizard_step_one_path
    fill_in 'proxy_name', with: 'Funk Prox'
    click_button 'Next'

    expect(page).to have_content('New Proxy: URL')
    expect(user.proxies.where(name: 'Funk Prox').count).to eq(1)
  end
end
