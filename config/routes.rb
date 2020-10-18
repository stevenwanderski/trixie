Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  get '/proxies/:user_slug/:proxy_slug', to: 'proxies#get'
  post '/proxies/:user_slug/:proxy_slug', to: 'proxies#post'

  namespace :dashboard do
    resources :proxies
    get '/slug', to: 'slug#edit'
    put '/slug', to: 'slug#update'

    get '/proxy_wizard/new/step_one', to: 'proxy_wizard#step_one', as: :proxy_wizard_step_one
    get '/proxy_wizard/:id/step_two', to: 'proxy_wizard#step_two', as: :proxy_wizard_step_two
    get '/proxy_wizard/:id/step_three', to: 'proxy_wizard#step_three', as: :proxy_wizard_step_three
    get '/proxy_wizard/:id/step_four', to: 'proxy_wizard#step_four', as: :proxy_wizard_step_four
    post '/proxy_wizard', to: 'proxy_wizard#create'
    put '/proxy_wizard/:id', to: 'proxy_wizard#update', as: :proxy_wizard_update

    get '/settings', to: 'settings#index'
    put '/settings', to: 'settings#update'
  end
end
