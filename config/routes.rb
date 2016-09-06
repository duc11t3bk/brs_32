Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  root "static_pages#home"
  resources :books
  resources :users do
    resources :requests, only: [:index, :new, :create, :destroy]
    resources :relationships, only: [:create, :destroy, :index]
  end
  resources :likes, only: [:create, :edit]
  namespace :admin do
    root "books#index"
    resources :books
    resources :requests, only: [:index, :update]
    resources :publishers
    resources :authors
    resources :languages
    resources :categories, only: [:index, :new, :create]
  end
  resources :user_books
  resources :comments
end
