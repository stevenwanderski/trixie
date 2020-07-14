class ApplicationController < ActionController::Base
  def after_sign_in_path_for(user)
    dashboard_proxies_path
  end
end
