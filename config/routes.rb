Rails.application.routes.draw do
  root 'users#new'
  resources :users, only: %i[create update]
  get :profile, to: 'users#profile'
end
