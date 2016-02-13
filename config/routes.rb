Rails.application.routes.draw do

  root 'home#show'
  
  resources :posts
  resources :users
  resources :comments, only: [:create, :destroy]  
  resources :books, only: [:index] do
    resources :parts, only: [:show]
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  get 'about' => 'about#show'
  
  get 'contact' => 'contact#show'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'password_resets/new'
  get 'password_resets/edit'
  
end
