Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :users
  resources :vehicles do
    collection do 
      post 'lookup'
    end
  end 
  resources :register_as
  resources :register_bs
  resources :register_cs
  resources :register_ds
  resources :register_es


  get '/register', to: 'users#create'
  get '/signup', to: 'users#new'
  get ':controller/:action'
  get ':controller/:action/:id'
  get ':controller/:action/:id.:format'
end
