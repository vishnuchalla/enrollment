Rails.application.routes.draw do
  resources :waitlists
  resources :admins
  resources :enrolls
  resources :instructors
  resources :students
  resources :courses
  resources :users
  root 'home#index'
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: "users#signup", as: 'signup'
  get 'login', to: "sessions#new", as: 'login'
  get 'logout', to: "sessions#destroy", as: 'logout'
end
