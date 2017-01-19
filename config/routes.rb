Rails.application.routes.draw do

  resources :pets
  devise_for :users #, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
  resources :users, only: [:index, :show, :settings]
  get '/users/:id/settings', to: 'users#settings', as: 'settings_user'
end
