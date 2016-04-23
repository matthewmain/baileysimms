Rails.application.routes.draw do

  root 'home#show'
  
  resources :posts
  resources :users
    patch 'log_shares' => 'users#log_shares'
  resources :comments, only: [:create, :destroy]
  resources :replies, only: [:create, :destroy]  
  resources :books, only: [:index] do
    resources :parts, only: [:show]
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  get 'about' => 'about#show'
  
  #get 'contact' => 'contact#show'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'password_resets/new'
  get 'password_resets/edit'

  #Omniauth Facebook
  match 'auth/:provider/callback', to: 'fb_sessions#create'             , via: [:get, :post]
  match 'auth/failure', to: redirect('/')                               , via: [:get, :post]
  match 'fb_disconnect', to: 'fb_sessions#destroy', as: 'fb_disconnect' , via: [:get, :post]
  
end
