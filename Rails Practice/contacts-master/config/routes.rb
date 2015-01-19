Rails.application.routes.draw do
  resources :users, only: [:create, :destroy, :index, :show, :update] do
    resources :contacts, only: [:index]
  end

  resources :contact_shares, only: [:create, :destroy]

  resources :contacts, only: [:create, :destroy, :show, :update] do
    member do
      get 'favorite'
    end
  end

  resources :comments, only: [:index, :create, :destroy, :show, :update]
end
