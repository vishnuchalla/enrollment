Rails.application.routes.draw do
  resources :waitlists
  resources :admins
  resources :enrolls do
    resources :studentenroll
  end
  resources :instructors
  resources :students do 
    get "test"
  end
  resources :courses do
    get "wait"
    get "waitremove"
  end
  resources :users
  root 'home#index'
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: "users#signup", as: 'signup'
  get 'login', to: "sessions#new", as: 'login'
  get 'logout', to: "sessions#destroy", as: 'logout'
end
