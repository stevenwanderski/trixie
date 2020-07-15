Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  get '/proxies/:user_slug/:proxy_slug', to: 'proxies#get'
  post '/proxies/:user_slug/:proxy_slug', to: 'proxies#post'

  namespace :dashboard do
    resources :proxies
    get '/settings', to: 'settings#index'
    put '/settings', to: 'settings#update'
  end
end
