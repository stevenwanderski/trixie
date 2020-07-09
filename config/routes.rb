Rails.application.routes.draw do
  devise_for :users

  resources :proxies

  namespace :admin do
    get '/dashboard', to: 'dashboard#index'

    resources :content_types
  end
end
