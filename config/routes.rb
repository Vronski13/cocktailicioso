Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/create'
  get 'reviews/edit'
  get 'reviews/index'
  root to: 'cocktails#index'
  devise_for :users
  resources :users, only: [:show] do
    resources :cocktails, only: [:my_cocktails, :edit, :new, :show, :create, :update] do
      collection do
        get :my_cocktails
      end
      resources :doses, only: [:new, :create]
    end
  end

  resources :doses, only: [:destroy]
  resources :cocktails, only: [:destroy]
end
