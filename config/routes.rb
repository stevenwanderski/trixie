Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  get '/proxies/:id', to: 'proxies#get'
  post '/proxies/:id', to: 'proxies#post'

  namespace :dashboard do
    resources :proxies
  end
end
