Rails.application.routes.draw do
  resources :pets
  devise_for :users #, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
  get '/users/followers', to: 'users#followers', as: 'followers'
  resources :users, only: [:index, :show, :update]
  get '/users/:id/settings', to: 'users#settings', as: 'settings_user'
  post '/users/:id/like', to: 'users#like', as: 'like_user'
  post '/users/:id/unlike', to: 'users#unlike', as: 'unlike_user'

end
