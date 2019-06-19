Rails.application.routes.draw do
  root 'users#new'
  resources :users, only: %i[create update]
  get :profile, to: 'users#profile'

  get :login, to: 'sessions#new'
  post :sessions, to: 'sessions#create', as: :sessions
  get :logout, to: 'sessions#destroy'

  resources :password_resets

  match '*path' => redirect('/'), via: :get
end
