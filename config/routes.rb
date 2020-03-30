Rails.application.routes.draw do
  root to: 'cocktails#index'
  devise_for :users
  resources :cocktails, only: [:show, :new, :create] do
    resources :doses, only: [:new, :create]
  end
  resources :doses, only: [:destroy]
  resources :users
end
