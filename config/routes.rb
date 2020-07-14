Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resources :proxies

  namespace :dashboard do
    resources :proxies
  end
end
