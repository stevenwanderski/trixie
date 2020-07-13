Rails.application.routes.draw do
  devise_for :users

  resources :proxies

  namespace :dashboard do
    resources :proxies
  end

  # namespace :admin do
  #   get '/dashboard', to: 'dashboard#index'
  #
  #   resources :content_types
  # end
end
