Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/create'
  get 'reviews/edit'
  get 'reviews/index'
  root to: 'cocktails#index'
  devise_for :users
  resources :users, only: [:show] do
    resources :cocktails, only: [:my_cocktails] do
      collection do
        get :my_cocktails
      end
    end
  end
  resources :cocktails, only: [:show, :new, :create] do
    resources :doses, only: [:new, :create]
  end
  resources :doses, only: [:destroy]

end
