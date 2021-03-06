Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"
  get '/users/followers', to: 'users#followers', as: 'followers'
  resources :users, only: [:show, :update]
  get '/users/:id/settings', to: 'users#edit', as: 'edit_user'
  post '/users/:id/like', to: 'users#like', as: 'like_user'
  post '/users/:id/unlike', to: 'users#unlike', as: 'unlike_user'

  get '/pets/sale', to: 'pets#sale', as: 'sale'
  get '/pets/goodhands', to: 'pets#goodhands', as: 'goodhands'
  get '/pets/copulation', to: 'pets#copulation', as: 'copulation'

  resources :pets, only: [:show, :new, :edit, :create, :update, :destroy]
  get '/pets/:id/advert', to: 'pets#advert', as: 'advert_pet'

  get '/locales/:locale', to: 'locales#show', as: 'locales'
  delete '/pets/:id/advert_destroy', to: 'pets#advert_destroy', as: 'advert_destroy'

  resources :cities, only: [] do
    get :search, :on => :collection
  end
end
