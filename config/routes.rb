Rails.application.routes.draw do
  devise_for :users #, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
  get '/users/followers', to: 'users#followers', as: 'followers'
  resources :users, only: [:show, :update]
  get '/users/:id/settings', to: 'users#edit', as: 'edit_user'
  post '/users/:id/like', to: 'users#like', as: 'like_user'
  post '/users/:id/unlike', to: 'users#unlike', as: 'unlike_user'

  resources :pets, only: [:show, :new, :edit, :create, :update, :destroy]
  get '/pets/:id/advert', to: 'pets#advert', as: 'advert_pet'

  get '/locales/:locale', to: 'locales#show', as: 'locales'
  delete '/pets/:id/advert_destroy', to: 'pets#advert_destroy', as: 'advert_destroy'

  resources :cities, only: [] do
    get :search, :on => :collection
  end
end
