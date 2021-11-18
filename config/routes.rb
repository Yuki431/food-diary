Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  
  resources :users, only: [:index, :create, :destroy]
  
  resources :foods, only: [:index, :new, :create, :edit, :update, :destroy]
  get 'foods/:date', to: 'foods#show'
  
  resources :weights, only: [:new, :create, :edit, :update, :destroy]
  
  resources :diaries, only: [:new, :create, :edit, :update, :destroy]
end