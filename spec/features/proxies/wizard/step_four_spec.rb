require 'rails_helper'

describe 'Proxies: Wizard: Step Four' do
  let(:proxy) { create(:proxy, user: user) }
  let(:user) { create(:user) }

  before do
    login_as(user)
  end

  context 'when no data was added' do
    it 'redirects to the proxy edit page' do
      visit dashboard_proxy_wizard_step_four_path(proxy)
      click_button 'Finish'

      expect(page).to have_current_path(edit_dashboard_proxy_path(proxy))
    end
  end
end
